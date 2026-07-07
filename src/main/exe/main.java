package exe;

import presentation.PresentationController;
/**
 *
 * @author guiu
 */
public class Main {
    private static PresentationController CP;
    public static void main (String[] args) throws Exception {
        System.out.println("Iniciant controlador de presentació...");
        CP = new PresentationController();
        CP.inicializarBaseDeDatos();
        CP.importFromDB();
        
    }
    
}
