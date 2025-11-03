package test.urlAnnotations;

import framework.annotations.Controller;
import framework.annotations.Url;
import java.io.File;
import java.lang.reflect.Method;
import java.net.URL;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

public class Main {

    private static final Map<String, Method> routes = new HashMap<>();

    public static void main(String[] args) throws Exception {
        System.out.println("SCAN DU CLASSPATH EN COURS...\n");
        scanPackage("test.urlAnnotations");
        displayMap();
    }

    private static void scanPackage(String packageName) throws Exception {
        String path = packageName.replace('.', '/');
        ClassLoader cl = Thread.currentThread().getContextClassLoader();
        Enumeration<URL> resources = cl.getResources(path);

        while (resources.hasMoreElements()) {
            URL resource = resources.nextElement();
            File dir = new File(resource.toURI());
            if (dir.exists()) {
                scanDirectory(dir, packageName);
            }
        }
    }

    private static void scanDirectory(File dir, String packageName) throws ClassNotFoundException {
        for (File file : dir.listFiles()) {
            if (file.isDirectory()) {
                scanDirectory(file, packageName + "." + file.getName());
            } else if (file.getName().endsWith(".class")) {
                String className = packageName + "." + file.getName().substring(0, file.getName().length() - 6);
                loadClass(className);
            }
        }
    }

    private static void loadClass(String className) throws ClassNotFoundException {
        Class<?> clazz = Class.forName(className);
        if (clazz.isAnnotationPresent(Controller.class)) {
            System.out.println("Classe annotée trouvée : " + clazz.getSimpleName());
            for (Method m : clazz.getDeclaredMethods()) {
                if (m.isAnnotationPresent(Url.class)) {
                    Url url = m.getAnnotation(Url.class);
                    routes.put(url.value(), m);
                    System.out.println("  → " + url.value() + " → " + m.getName() + "()");
                }
            }
            System.out.println();
        }
    }

    private static void displayMap() {
        System.out.println("=== MAP FINALE (URL → Méthode) ===");
        if (routes.isEmpty()) {
            System.out.println("Aucune route trouvée.");
        } else {
            routes.forEach((url, method) ->
                System.out.println(url + " → " + method.getDeclaringClass().getSimpleName() + "." + method.getName() + "()")
            );
        }
    }
}