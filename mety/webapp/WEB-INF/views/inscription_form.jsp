<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>${titre}</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; }
        h1 { color: #333; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, select, textarea { width: 100%; padding: 8px; box-sizing: border-box; }
        button { background-color: #4CAF50; color: white; padding: 10px 20px; border: none; cursor: pointer; font-size: 16px; }
        button:hover { background-color: #45a049; }
        .info { background-color: #e7f3fe; padding: 10px; border-left: 4px solid #2196F3; margin-bottom: 20px; }
    </style>
</head>
<body>
    <h1>${titre} - SPRINT 8</h1>
    
    <div class="info">
        <strong>Test Map&lt;String, Object&gt;</strong><br>
        Tous les champs du formulaire seront automatiquement injectés dans un Map !
    </div>
    
    <form action="inscription" method="post">
        <div class="form-group">
            <label for="nom">Nom complet :</label>
            <input type="text" id="nom" name="nom" value="RAKOTO Jean" required>
        </div>
        
        <div class="form-group">
            <label for="email">Email :</label>
            <input type="email" id="email" name="email" value="rakoto@example.com" required>
        </div>
        
        <div class="form-group">
            <label for="age">Âge :</label>
            <input type="number" id="age" name="age" value="25" required>
        </div>
        
        <div class="form-group">
            <label for="niveau">Niveau d'études :</label>
            <select id="niveau" name="niveau">
                <option value="Licence">Licence</option>
                <option value="Master" selected>Master</option>
                <option value="Doctorat">Doctorat</option>
            </select>
        </div>
        
        <div class="form-group">
            <label for="specialite">Spécialité :</label>
            <input type="text" id="specialite" name="specialite" value="Informatique">
        </div>
        
        <div class="form-group">
            <label for="commentaire">Commentaire :</label>
            <textarea id="commentaire" name="commentaire" rows="4">Étudiant motivé</textarea>
        </div>
        
        <button type="submit">S'inscrire (Test Map)</button>
    </form>
    
    <p style="margin-top: 20px; color: #666;">
        <em>Dans la console, vous verrez tous les paramètres récupérés via getParameterMap()</em>
    </p>
</body>
</html>
