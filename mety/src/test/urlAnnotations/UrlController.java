package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;
import framework.Annotation.RequestParam;
import framework.Annotation.GetMapping;
import framework.Annotation.PostMapping;
import framework.Annotation.RestApi;
import framework.util.ModelView;
import test.model.Employe;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;

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

    // SPRINT 8-BIS : GET affiche formulaire employe
    @GetMapping("/employe/nouveau")
    public ModelView formulaireEmploye() {
        System.out.println("=== GET /employe/nouveau : affichage formulaire ===");
        ModelView mv = new ModelView("employe_form");
        mv.addAttribute("titre", "Nouvel Employé");
        return mv;
    }

    // SPRINT 8-BIS : POST avec objet Employe auto-binding
    @PostMapping("/employe/save")
    public String saveEmploye(Employe emp) {
        System.out.println("\n=== SPRINT 8-BIS : Objet Employe reçu ===");
        System.out.println(emp);
        
        StringBuilder result = new StringBuilder();
        result.append("<h1>SPRINT 8-BIS : Auto-binding d'objet</h1>");
        result.append("<h2>Employé créé automatiquement</h2>");
        result.append("<table border='1' style='border-collapse: collapse; margin: 20px;'>");
        result.append("<tr><th style='padding: 10px;'>Champ</th><th style='padding: 10px;'>Valeur</th></tr>");
        result.append("<tr><td style='padding: 10px;'>ID</td><td style='padding: 10px;'>").append(emp.getId()).append("</td></tr>");
        result.append("<tr><td style='padding: 10px;'>Nom</td><td style='padding: 10px;'>").append(emp.getNom()).append("</td></tr>");
        result.append("<tr><td style='padding: 10px;'>Email</td><td style='padding: 10px;'>").append(emp.getEmail()).append("</td></tr>");
        result.append("<tr><td style='padding: 10px;'>Âge</td><td style='padding: 10px;'>").append(emp.getAge()).append("</td></tr>");
        result.append("<tr><td style='padding: 10px;'>Salaire</td><td style='padding: 10px;'>").append(emp.getSalaire()).append("</td></tr>");
        result.append("<tr><td style='padding: 10px;'>Poste</td><td style='padding: 10px;'>").append(emp.getPoste()).append("</td></tr>");
        result.append("<tr><td style='padding: 10px;'>Date Embauche</td><td style='padding: 10px;'>").append(emp.getDateEmbauche()).append("</td></tr>");
        result.append("</table>");
        result.append("<p style='background: #e7f3fe; padding: 10px; border-left: 4px solid #2196F3;'>");
        result.append("<strong>✓ L'objet Employe a été créé automatiquement !</strong><br>");
        result.append("Le framework a utilisé la réflexion pour :<br>");
        result.append("1. Instancier l'objet<br>");
        result.append("2. Trouver les setters (setNom, setEmail, etc.)<br>");
        result.append("3. Convertir les valeurs String → types corrects<br>");
        result.append("4. Appeler les setters");
        result.append("</p>");
        result.append("<p><a href='../employe/nouveau'>Ajouter un autre employé</a></p>");
        
        return result.toString();
    }

    // SPRINT 9: API REST - Retourne un objet en JSON
    @GetMapping("/api/employe/{id}")
    @RestApi
    public Employe getEmployeApi(String id) {
        System.out.println("\n=== SPRINT 9 : API GET /api/employe/" + id + " ===");
        
        // Créer un employé fictif
        Employe emp = new Employe();
        emp.setId(Integer.parseInt(id));
        emp.setNom("RAKOTO Jean");
        emp.setEmail("rakoto@example.mg");
        emp.setAge(28);
        emp.setSalaire(2500000.0);
        emp.setPoste("Développeur");
        emp.setDateEmbauche(new java.util.Date());
        
        return emp;
    }

    // SPRINT 9: API REST - Retourne une liste en JSON
    @GetMapping("/api/employes")
    @RestApi
    public List<Employe> getAllEmployesApi() {
        System.out.println("\n=== SPRINT 9 : API GET /api/employes ===");
        
        List<Employe> employes = new ArrayList<>();
        
        // Créer quelques employés fictifs
        Employe emp1 = new Employe();
        emp1.setId(1);
        emp1.setNom("RAKOTO Jean");
        emp1.setEmail("rakoto@example.mg");
        emp1.setAge(28);
        emp1.setSalaire(2500000.0);
        emp1.setPoste("Développeur");
        
        Employe emp2 = new Employe();
        emp2.setId(2);
        emp2.setNom("RABE Marie");
        emp2.setEmail("rabe@example.mg");
        emp2.setAge(32);
        emp2.setSalaire(3000000.0);
        emp2.setPoste("Chef de projet");
        
        Employe emp3 = new Employe();
        emp3.setId(3);
        emp3.setNom("RANDRIA Paul");
        emp3.setEmail("randria@example.mg");
        emp3.setAge(25);
        emp3.setSalaire(2200000.0);
        emp3.setPoste("Analyste");
        
        employes.add(emp1);
        employes.add(emp2);
        employes.add(emp3);
        
        return employes;
    }

    // SPRINT 9: API REST - Retourne ModelView en JSON (extrait data)
    @GetMapping("/api/stats")
    @RestApi
    public ModelView getStatsApi() {
        System.out.println("\n=== SPRINT 9 : API GET /api/stats ===");
        
        ModelView mv = new ModelView();
        mv.addAttribute("totalEmployes", 15);
        mv.addAttribute("totalSalaires", 37500000.0);
        mv.addAttribute("moyenneSalaire", 2500000.0);
        mv.addAttribute("departements", 3);
        
        return mv;
    }
}
