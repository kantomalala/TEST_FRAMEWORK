package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;

@Controller
public class UrlController {

    @Url("/test1")
    public String hello() {
        return "Bonjour depuis le contrôleur ! Ceci est le Sprint 4";
    }

    @Url("/test2")
    public String bye() {
        return "Au revoir ! La valeur retournée est affichée directement";
    }

    @Url("/test3")
    public void classic() {
        // Pas de return → affichage classique
    }
}