package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;
import framework.Annotation.RequestParam;
import framework.Annotation.GetMapping;
import framework.Annotation.PostMapping;
import framework.Annotation.RestApi;
import framework.Annotation.SessionParam;
import framework.util.ModelView;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

    // SPRINT 10 : Affichage du formulaire d'upload
    @GetMapping("/document/nouveau")
    public ModelView formulaireUpload() {
        System.out.println("=== GET /document/nouveau : affichage formulaire upload ===");
        ModelView mv = new ModelView("document_form");
        mv.addAttribute("titre", "Upload de Document");
        return mv;
    }

    // SPRINT 10 : Réception du fichier uploadé
    @PostMapping("/document/upload")
    public String uploadDocument(
            @RequestParam("fichier") framework.util.UploadedFile fichier, 
            @RequestParam("titre") String titre, 
            @RequestParam("description") String description) {
        System.out.println("\n=== SPRINT 10 : Upload de fichier ===");
        System.out.println("Titre: " + titre);
        System.out.println("Description: " + description);
        
        StringBuilder result = new StringBuilder();
        result.append("<h1>SPRINT 10 : Upload de Fichier</h1>");
        result.append("<h2>Document reçu avec succès</h2>");
        
        if (fichier != null && !fichier.isEmpty()) {
            System.out.println("Fichier reçu: " + fichier.getFileName());
            System.out.println("Taille: " + fichier.getSize() + " bytes");
            System.out.println("Type: " + fichier.getContentType());
            
            result.append("<table border='1' style='border-collapse: collapse; margin: 20px;'>");
            result.append("<tr><th style='padding: 10px;'>Information</th><th style='padding: 10px;'>Valeur</th></tr>");
            result.append("<tr><td style='padding: 10px;'>Titre</td><td style='padding: 10px;'>").append(titre).append("</td></tr>");
            result.append("<tr><td style='padding: 10px;'>Description</td><td style='padding: 10px;'>").append(description).append("</td></tr>");
            result.append("<tr><td style='padding: 10px;'>Nom du fichier</td><td style='padding: 10px;'>").append(fichier.getFileName()).append("</td></tr>");
            result.append("<tr><td style='padding: 10px;'>Type MIME</td><td style='padding: 10px;'>").append(fichier.getContentType()).append("</td></tr>");
            result.append("<tr><td style='padding: 10px;'>Taille</td><td style='padding: 10px;'>").append(fichier.getSize()).append(" bytes</td></tr>");
            result.append("</table>");
            
            // Test de sauvegarde dans un dossier temporaire
            try {
                String uploadDir = "C:\\temp\\uploads\\";
                java.io.File directory = new java.io.File(uploadDir);
                if (!directory.exists()) {
                    directory.mkdirs();
                }
                
                String savedPath = uploadDir + fichier.getFileName();
                fichier.saveTo(savedPath);
                
                result.append("<p style='background: #d4edda; padding: 10px; border-left: 4px solid #28a745;'>");
                result.append("<strong>✓ Fichier sauvegardé avec succès !</strong><br>");
                result.append("Emplacement : ").append(savedPath);
                result.append("</p>");
                
                System.out.println("Fichier sauvegardé : " + savedPath);
            } catch (Exception e) {
                result.append("<p style='background: #f8d7da; padding: 10px; border-left: 4px solid #dc3545;'>");
                result.append("<strong>✗ Erreur lors de la sauvegarde :</strong> ").append(e.getMessage());
                result.append("</p>");
                System.err.println("Erreur sauvegarde : " + e.getMessage());
            }
            
            result.append("<p style='background: #e7f3fe; padding: 10px; border-left: 4px solid #2196F3;'>");
            result.append("<strong>Comment ça marche ?</strong><br>");
            result.append("1. Le formulaire utilise enctype='multipart/form-data'<br>");
            result.append("2. Le FrontServlet détecte le paramètre de type UploadedFile<br>");
            result.append("3. Il extrait les bytes du fichier avec request.getPart()<br>");
            result.append("4. L'objet UploadedFile est injecté dans la méthode du controller<br>");
            result.append("5. Vous pouvez ensuite sauvegarder ou manipuler le fichier");
            result.append("</p>");
        } else {
            result.append("<p style='background: #f8d7da; padding: 10px; border-left: 4px solid #dc3545;'>");
            result.append("<strong>✗ Aucun fichier n'a été uploadé !</strong>");
            result.append("</p>");
        }
        
        result.append("<p><a href='../document/nouveau'>Uploader un autre fichier</a></p>");
        
        return result.toString();
    }

    // SPRINT 11 : Sessions - ajouter/récupérer/supprimer des attributs
    @PostMapping("/session/set")
    public String setSessionAttr(@RequestParam("key") String key, @RequestParam("value") String value, HttpSession session) {
        System.out.println("=== POST /session/set : key=" + key + " value=" + value + " ===");
        session.setAttribute(key, value);
        return "Attribut '" + key + "' ajouté à la session → " + value;
    }

    @GetMapping("/session/get")
    public String getSessionAttr(@RequestParam("key") String key, HttpSession session) {
        System.out.println("=== GET /session/get : key=" + key + " ===");
        Object v = session.getAttribute(key);
        return v != null ? v.toString() : "null";
    }

    @PostMapping("/session/remove")
    public String removeSessionAttr(@RequestParam("key") String key, HttpSession session) {
        System.out.println("=== POST /session/remove : key=" + key + " ===");
        session.removeAttribute(key);
        return "Attribut '" + key + "' supprimé de la session";
    }

    @GetMapping("/session/show")
    @RestApi
    public Map<String, Object> showSession(HttpSession session) {
        System.out.println("=== GET /session/show ===");
        Map<String, Object> data = new java.util.HashMap<>();
        java.util.Enumeration<String> names = session.getAttributeNames();
        while (names.hasMoreElements()) {
            String n = names.nextElement();
            data.put(n, session.getAttribute(n));
        }
        return data;
    }

    // SPRINT 11 : Système de login avec @SessionParam
    @GetMapping("/auth/login")
    public ModelView formulaireLogin(@SessionParam("currentUser") String user) {
        System.out.println("=== GET /auth/login ===");
        System.out.println("Utilisateur connecté : " + user);
        
        // Si déjà connecté, afficher un message plutôt qu'une erreur
        if (user != null) {
            ModelView mv = new ModelView("login_form");
            mv.addAttribute("titre", "Déjà connecté");
            mv.addAttribute("message", "Vous êtes déjà connecté en tant que " + user);
            mv.addAttribute("alreadyLoggedIn", true);
            mv.addAttribute("currentUser", user);
            return mv;
        }
        
        ModelView mv = new ModelView("login_form");
        mv.addAttribute("titre", "Connexion - SPRINT 11");
        mv.addAttribute("message", "Veuillez vous connecter");
        mv.addAttribute("alreadyLoggedIn", false);
        return mv;
    }

    @PostMapping("/auth/login")
    public String processLogin(@RequestParam("username") String username, 
                              @RequestParam("password") String password,
                              HttpSession session) {
        System.out.println("=== POST /auth/login : " + username + " ===");
        
        // Vérification credentials (en dur pour la démo)
        boolean validLogin = false;
        if (("admin".equals(username) && "123".equals(password)) ||
            ("user".equals(username) && "pass".equals(password)) ||
            ("demo".equals(username) && "demo".equals(password))) {
            validLogin = true;
        }
        
        StringBuilder result = new StringBuilder();
        result.append("<h1>SPRINT 11 : Authentification</h1>");
        
        if (validLogin) {
            // Enregistrer l'utilisateur dans la session
            session.setAttribute("currentUser", username);
            System.out.println("Utilisateur connecté : " + username);
            
            result.append("<h2>\u2713 Connexion réussie !</h2>");
            result.append("<div style='background: #d4edda; padding: 20px; border-left: 4px solid #28a745; margin: 20px 0; border-radius: 8px;'>");
            result.append("<strong>Bienvenue " + username + " !</strong><br>");
            result.append("Vous êtes maintenant connecté.<br>");
            result.append("Votre session contient : <code>currentUser = " + username + "</code>");
            result.append("</div>");
            result.append("<p><a href='../dashboard' style='display: inline-block; padding: 12px 25px; background: #28a745; color: white; text-decoration: none; border-radius: 5px; margin: 10px;'>\u2192 Accéder au tableau de bord</a></p>");
            result.append("<p><a href='../auth/logout' style='display: inline-block; padding: 10px 20px; background: #dc3545; color: white; text-decoration: none; border-radius: 5px;'>Déconnexion</a></p>");
        } else {
            result.append("<h2>\u2717 Échec de la connexion</h2>");
            result.append("<div style='background: #f8d7da; padding: 20px; border-left: 4px solid #dc3545; margin: 20px 0; border-radius: 8px;'>");
            result.append("<strong>Identifiants incorrects !</strong><br>");
            result.append("Utilisateur : " + username + "<br>");
            result.append("<small>Essayez : admin/123, user/pass, ou demo/demo</small>");
            result.append("</div>");
            result.append("<p><a href='../auth/login' style='display: inline-block; padding: 10px 20px; background: #007bff; color: white; text-decoration: none; border-radius: 5px;'>\u2190 Réessayer</a></p>");
        }
        
        result.append("<div style='background: #e7f3fe; padding: 15px; border-left: 4px solid #2196F3; margin-top: 30px; border-radius: 8px;'>");
        result.append("<strong>💡 Démonstration @SessionParam</strong><br>");
        result.append("1. POST /auth/login vérifie username/password<br>");
        result.append("2. Si valid : <code>session.setAttribute(\"currentUser\", username)</code><br>");
        result.append("3. Pages protégées utilisent <code>@SessionParam(\"currentUser\")</code><br>");
        result.append("4. Si param null = pas connecté, sinon = utilisateur connecté");
        result.append("</div>");
        
        return result.toString();
    }
    
    @GetMapping("/dashboard")
    public String dashboard(@SessionParam("currentUser") String user) {
        System.out.println("=== GET /dashboard ===");
        System.out.println("Utilisateur depuis session : " + user);
        
        StringBuilder result = new StringBuilder();
        result.append("<h1>SPRINT 11 : Tableau de Bord</h1>");
        
        if (user != null) {
            result.append("<h2>\u2713 Accès autorisé</h2>");
            result.append("<div style='background: #d1ecf1; padding: 20px; border-left: 4px solid #bee5eb; margin: 20px 0; border-radius: 8px;'>");
            result.append("<strong>Bienvenue " + user + " !</strong><br>");
            result.append("Voici votre tableau de bord personnel.<br>");
            result.append("Session active : <code>@SessionParam(\"currentUser\") = \"" + user + "\"</code>");
            result.append("</div>");
            result.append("<h3>Actions disponibles :</h3>");
            result.append("<ul style='line-height: 2;'>");
            result.append("<li><a href='session/show'>\u2192 Voir tous les attributs de session (JSON)</a></li>");
            result.append("<li><a href='api/employes'>\u2192 API Liste des employés (JSON)</a></li>");
            result.append("<li><a href='employe/nouveau'>\u2192 Ajouter un employé</a></li>");
            result.append("</ul>");
            result.append("<p><a href='auth/logout' style='display: inline-block; padding: 10px 20px; background: #dc3545; color: white; text-decoration: none; border-radius: 5px;'>\u2717 Déconnexion</a></p>");
        } else {
            result.append("<h2>\u2717 Accès refusé</h2>");
            result.append("<div style='background: #f8d7da; padding: 20px; border-left: 4px solid #f5c6cb; margin: 20px 0; border-radius: 8px;'>");
            result.append("<strong>Vous devez être connecté pour accéder à cette page !</strong><br>");
            result.append("Session : <code>@SessionParam(\"currentUser\") = null</code><br>");
            result.append("<small>Aucun utilisateur trouvé dans la session HTTP</small>");
            result.append("</div>");
            result.append("<p><a href='auth/login' style='display: inline-block; padding: 12px 25px; background: #007bff; color: white; text-decoration: none; border-radius: 5px;'>\u2192 Se connecter</a></p>");
        }
        
        return result.toString();
    }
    
    @PostMapping("/auth/logout")
    public String logout(HttpSession session) {
        System.out.println("=== POST /auth/logout ===");
        
        String user = (String) session.getAttribute("currentUser");
        session.invalidate(); // Détruire toute la session
        
        System.out.println("Session détruite pour : " + user);
        
        StringBuilder result = new StringBuilder();
        result.append("<h1>SPRINT 11 : Déconnexion</h1>");
        result.append("<h2>\u2713 Déconnexion réussie</h2>");
        result.append("<div style='background: #d4edda; padding: 20px; border-left: 4px solid #28a745; margin: 20px 0; border-radius: 8px;'>");
        if (user != null) {
            result.append("<strong>Au revoir " + user + " !</strong><br>");
        }
        result.append("Votre session a été détruite.<br>");
        result.append("<code>session.invalidate()</code> appelé avec succès.");
        result.append("</div>");
        result.append("<p><a href='../auth/login' style='display: inline-block; padding: 12px 25px; background: #007bff; color: white; text-decoration: none; border-radius: 5px;'>\u2192 Se reconnecter</a></p>");
        result.append("<p><a href='../dashboard' style='display: inline-block; padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 5px;'>\u2192 Tester l'accès dashboard (doit être refusé)</a></p>");
        
        return result.toString();
    }
}
