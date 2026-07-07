
# Variables
SRC_DIR = src/main
TEST_SRC_DIR = src/test
BUILD_DIR = build
OUT_DIR = $(BUILD_DIR)/classes
TEST_OUT_DIR = $(BUILD_DIR)/test-classes
MAIN_CLASS = exe.Main
LIB_DIR = lib
JAR_DIR = $(BUILD_DIR)/libs
DOCS_DIR = docs/javadoc
DB_DIR = db
JAR_FILE = $(JAR_DIR)/app.jar

# Encontrar todos los archivos .java dentro de SRC_DIR y TEST_SRC_DIR
SOURCES = $(shell find $(SRC_DIR) -name "*.java")
TEST_SOURCES = $(shell find $(TEST_SRC_DIR) -name "*.java")

# Construir el classpath con las dependencias en lib/
CLASSPATH = $(LIB_DIR)/*:$(OUT_DIR):$(TEST_OUT_DIR)

# Comandos
JAVAC = javac
JAVA = java
JAR = jar
JAVADOC = javadoc

# Flags
JAVAC_FLAGS = -d $(OUT_DIR) -classpath $(CLASSPATH)
TEST_JAVAC_FLAGS = -d $(TEST_OUT_DIR) -classpath $(CLASSPATH)

# Regla principal: compilar todo
all:
	@echo "Compiling all Java files..."
	@mkdir -p $(OUT_DIR)
	$(JAVAC) $(JAVAC_FLAGS) $(SOURCES)

# Compilar y ejecutar pruebas
test: all
	@echo "Compiling and running tests..."
	@mkdir -p $(TEST_OUT_DIR)
	$(JAVAC) $(TEST_JAVAC_FLAGS) $(TEST_SOURCES)
	@echo "Running tests..."
	$(JAVA) -cp $(CLASSPATH) org.junit.runner.JUnitCore \
	$(shell find $(TEST_SRC_DIR) -name "*.java" | sed 's|$(TEST_SRC_DIR)/||' | sed 's|/|.|g' | sed 's|.java||')

# Compilar solo los tests sin ejecutarlos
compile-tests:
	@echo "Compiling tests..."
	@mkdir -p $(TEST_OUT_DIR)
	$(JAVAC) $(TEST_JAVAC_FLAGS) $(TEST_SOURCES)

# Crear un archivo .jar en la carpeta build/libs, incluyendo dependencias (fat jar)
jar: all
	@echo "Building Fat JAR..."
	@mkdir -p $(JAR_DIR) temp-lib
	for lib in $(LIB_DIR)/*.jar; do \
		unzip -qo $$lib -d temp-lib; \
	done
	$(JAR) cfe $(JAR_FILE) $(MAIN_CLASS) -C $(OUT_DIR) . -C temp-lib .
	@rm -rf temp-lib
	@echo "JAR created at $(JAR_FILE)"

# Generar documentación Javadoc
javadoc:
	@echo "Generating Javadoc..."
	@mkdir -p $(DOCS_DIR)
	$(JAVADOC) -d $(DOCS_DIR) -sourcepath $(SRC_DIR) -subpackages . -classpath $(CLASSPATH)
	@echo "Documentation generated at $(DOCS_DIR)"

# Ejecutar la aplicación desde clases compiladas
run: all
	@echo "Running application..."
	$(JAVA) -cp $(CLASSPATH) $(MAIN_CLASS)

# Limpiar los archivos generados
clean:
	@echo "Cleaning build artifacts..."
	rm -rf $(BUILD_DIR) temp-lib $(DOCS_DIR)

# Reiniciar la base de datos
cleanDB:
	@echo "Resetting database..."
	sqlite3 $(DB_DIR)/DataBase.db < $(DB_DIR)/reset.sql

# Ayuda
help:
	@echo "Available commands:"
	@echo "  all           - Compile all .java files"
	@echo "  jar           - Package the project into a .jar with dependencies"
	@echo "  javadoc       - Generate Javadoc documentation"
	@echo "  run           - Compile and run the application"
	@echo "  test          - Compile and run tests"
	@echo "  compile-tests - Compile tests without running them"
	@echo "  clean         - Remove all compiled files and artifacts"
	@echo "  cleanDB       - Reset the database using reset.sql"
	@echo "  help          - Show this help message"