package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;
import framework.Annotation.RequestParam;
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

    // SPRINT 6-TER : Paramètre dynamique dans l'URL
    @Url("/etudiant/{id}")
    public ModelView etudiantById(@RequestParam("id") int idEtudiant) {
        System.out.println("=== SPRINT 6-TER : URL dynamique ===");
        System.out.println("URL /etudiant/{id} → idEtudiant = " + idEtudiant);
        
        ModelView mv = new ModelView("etudiant_detail");
        mv.addAttribute("id", idEtudiant);
        mv.addAttribute("nom", "Étudiant n°" + idEtudiant);
        mv.addAttribute("message", "Détails de l'étudiant avec ID extrait de l'URL");
        return mv;
    }

    // SPRINT 6-TER : Plusieurs paramètres dynamiques
    @Url("/cours/{idCours}/etudiant/{idEtudiant}")
    public String getCoursEtudiant(
        @RequestParam("idCours") int cours,
        @RequestParam("idEtudiant") int etudiant
    ) {
        return "Cours n°" + cours + " pour étudiant n°" + etudiant + " (SPRINT 6-TER)";
    }

    // SPRINT 6-BIS : Formulaire avec @RequestParam
    @Url("/etudiant/save")
    public ModelView save(
        @RequestParam("id") int idEtudiant,
        @RequestParam("nom") String nomComplet
    ) {
        System.out.println("=== SPRINT 6-BIS : @RequestParam ===");
        System.out.println("Formulaire id → idEtudiant = " + idEtudiant);
        System.out.println("Formulaire nom → nomComplet = " + nomComplet);
        
        ModelView mv = new ModelView("etudiant_saved");
        mv.addAttribute("id", idEtudiant);
        mv.addAttribute("nom", nomComplet);
        mv.addAttribute("message", "Étudiant enregistré avec @RequestParam !");
        return mv;
    }
}