package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;
import framework.Annotation.RequestParam;
import framework.Annotation.GetMapping;
import framework.Annotation.PostMapping;
import framework.util.ModelView;
import java.util.Map;

@Controller
public class UrlController {

    @Url("/test1")
    public String texte() {
        return "Ceci est une String simple → affiché en texte brut (Sprint 4)";
    }

    @Url("/test2")
public ModelView versJsp() {
    ModelView mv = new ModelView("test.jsp");
    mv.addAttribute("message", "Bonjour depuis le controller !");
    mv.addAttribute("year", 2025);
    return mv;
}

    @Url("/test3")
    public void classique() {
        // → affichage par défaut
    }

    @Url("/etudiant/{id}")
    public String etudiantById(String id) {
        return "Etudiant id = " + id + " (méthode GET reconnue depuis le pattern)";
    }

    @Url("/cours/{idCours}/etudiant/{idEtudiant}")
    public String getCoursEtudiant(String idCours, String idEtudiant) {
        return "Cours n°" + idCours + " pour étudiant n°" + idEtudiant + " (SPRINT 6-TER : plusieurs params dynamiques)";
    }

    // SPRINT 7: GET affiche le formulaire
    @GetMapping("/etudiant/save")
    public ModelView formulaireSave() {
        System.out.println("=== GET /etudiant/save : affichage du formulaire ===");
        ModelView mv = new ModelView("etudiant_form");
        mv.addAttribute("titre", "Nouveau étudiant");
        return mv;
    }

    // SPRINT 7: POST traite la soumission
    @PostMapping("/etudiant/save")
    public ModelView save(
        @RequestParam("id") int idEtudiant,
        @RequestParam("nom") String nomComplet
    ) {
        System.out.println("=== POST /etudiant/save : traitement du formulaire ===");
        System.out.println("Formulaire id → idEtudiant = " + idEtudiant);
        System.out.println("Formulaire nom → nomComplet = " + nomComplet);
        
        ModelView mv = new ModelView("etudiant_saved");
        mv.addAttribute("id", idEtudiant);
        mv.addAttribute("nom", nomComplet);
        mv.addAttribute("message", "Étudiant enregistré avec @PostMapping !");
        return mv;
    }

    // SPRINT 8: GET affiche un formulaire complexe
    @GetMapping("/inscription")
    public ModelView formulaireInscription() {
        System.out.println("=== GET /inscription : affichage formulaire ===");
        ModelView mv = new ModelView("inscription_form");
        mv.addAttribute("titre", "Inscription");
        return mv;
    }

    // SPRINT 8: POST avec Map auto-injection
    @PostMapping("/inscription")
    public String saveTest(Map<String, Object> values) {
        System.out.println("\n=== SPRINT 8: POST /inscription avec Map<String, Object> ===");
        System.out.println("Nombre de paramètres reçus : " + values.size());
        
        StringBuilder result = new StringBuilder();
        result.append("<h1>SPRINT 8 : Données du formulaire</h1>");
        result.append("<h2>Map auto-injecté (" + values.size() + " paramètres)</h2>");
        result.append("<ul>");
        
        values.forEach((key, value) -> {
            System.out.println("  " + key + " = " + value);
            result.append("<li><b>").append(key).append("</b> = ").append(value).append("</li>");
        });
        
        result.append("</ul>");
        result.append("<p><a href='inscription'>Retour au formulaire</a></p>");
        
        return result.toString();
    }
}