package test.urlAnnotations;

import framework.Servlet.Handler;
import framework.Servlet.HandlerScanner;
import java.util.Map;

public class TestScan {
    public static void main(String[] args) throws Exception {
        System.out.println("SCAN DU CLASSPATH EN COURS...\n");
        
        // Scanner le package test.urlAnnotations
        Map<String, Handler> handlers = HandlerScanner.scan(null, "test.urlAnnotations");
        
        if (handlers.isEmpty()) {
            System.out.println("Aucune route trouvée.");
        } else {
            handlers.forEach((url, handler) -> {
                System.out.println("Classe annotée trouvée : " + handler.controllerClass.getSimpleName());
                System.out.println("  → " + url + " → " + handler.method.getName() + "()");
            });
            
            System.out.println("\n=== MAP FINALE (URL → Méthode) ===");
            handlers.forEach((url, handler) -> 
                System.out.println(url + " → " + handler.controllerClass.getSimpleName() + "." + handler.method.getName() + "()")
            );
        }
    }
}