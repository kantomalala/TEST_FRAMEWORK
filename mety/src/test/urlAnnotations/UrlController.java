package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;
import framework.Annotation.RequestParam;
import framework.Annotation.GetMapping;
import framework.Annotation.PostMapping;
import framework.util.ModelView;

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
}