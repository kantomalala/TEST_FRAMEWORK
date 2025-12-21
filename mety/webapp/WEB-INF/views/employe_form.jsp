<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>${titre} - SPRINT 8-BIS</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            max-width: 700px; 
            margin: 50px auto; 
            padding: 20px; 
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 { 
            color: #333; 
            border-bottom: 3px solid #4CAF50;
            padding-bottom: 10px;
        }
        .form-group { 
            margin-bottom: 20px; 
        }
        label { 
            display: block; 
            margin-bottom: 5px; 
            font-weight: bold; 
            color: #555;
        }
        input, select { 
            width: 100%; 
            padding: 10px; 
            box-sizing: border-box; 
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        input:focus {
            outline: none;
            border-color: #4CAF50;
        }
        button { 
            background-color: #4CAF50; 
            color: white; 
            padding: 12px 30px; 
            border: none; 
            cursor: pointer; 
            font-size: 16px;
            border-radius: 4px;
            width: 100%;
            margin-top: 10px;
        }
        button:hover { 
            background-color: #45a049; 
        }
        .info { 
            background-color: #fff3cd; 
            padding: 15px; 
            border-left: 4px solid #ffc107; 
            margin-bottom: 25px;
            border-radius: 4px;
        }
        .info strong {
            color: #856404;
        }
        .field-info {
            font-size: 12px;
            color: #666;
            margin-top: 3px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>${titre}</h1>
        
        <div class="info">
            <strong>🚀 SPRINT 8-BIS : Auto-binding d'objet</strong><br>
            Tous les champs seront automatiquement mappés vers l'objet <code>Employe</code> !<br>
            Le framework utilise la <strong>réflexion</strong> pour créer et remplir l'objet.
        </div>
        
        <form action="../employe/save" method="post">
            <div class="form-group">
                <label for="id">ID :</label>
                <input type="number" id="id" name="id" value="1001" required>
                <div class="field-info">→ mapping automatique : emp.setId(int)</div>
            </div>
            
            <div class="form-group">
                <label for="nom">Nom complet :</label>
                <input type="text" id="nom" name="nom" value="RAKOTO Jean Paul" required>
                <div class="field-info">→ mapping : emp.setNom(String)</div>
            </div>
            
            <div class="form-group">
                <label for="email">Email :</label>
                <input type="email" id="email" name="email" value="rakoto@entreprise.mg" required>
                <div class="field-info">→ mapping : emp.setEmail(String)</div>
            </div>
            
            <div class="form-group">
                <label for="age">Âge :</label>
                <input type="number" id="age" name="age" value="30" required>
                <div class="field-info">→ mapping avec conversion : emp.setAge(int)</div>
            </div>
            
            <div class="form-group">
                <label for="salaire">Salaire :</label>
                <input type="number" id="salaire" name="salaire" step="0.01" value="2500000.50" required>
                <div class="field-info">→ mapping avec conversion : emp.setSalaire(double)</div>
            </div>
            
            <div class="form-group">
                <label for="poste">Poste :</label>
                <select id="poste" name="poste" required>
                    <option value="Développeur">Développeur</option>
                    <option value="Chef de projet" selected>Chef de projet</option>
                    <option value="Analyste">Analyste</option>
                    <option value="DBA">DBA</option>
                </select>
                <div class="field-info">→ mapping : emp.setPoste(String)</div>
            </div>
            
            <div class="form-group">
                <label for="dateEmbauche">Date d'embauche :</label>
                <input type="date" id="dateEmbauche" name="dateEmbauche" value="2024-01-15" required>
                <div class="field-info">→ mapping avec parsing : emp.setDateEmbauche(Date)</div>
            </div>
            
            <button type="submit">Enregistrer (Test Auto-binding)</button>
        </form>
        
        <p style="margin-top: 30px; padding: 15px; background-color: #e7f3fe; border-left: 4px solid #2196F3; border-radius: 4px;">
            <strong>💡 Comment ça marche ?</strong><br>
            1. Le framework détecte que le paramètre est un objet custom (Employe)<br>
            2. Il crée une instance vide : <code>new Employe()</code><br>
            3. Pour chaque champ HTML (name="nom", name="age"...) :<br>
            &nbsp;&nbsp;&nbsp;→ Il cherche le champ correspondant dans la classe Employe<br>
            &nbsp;&nbsp;&nbsp;→ Il trouve le setter (setNom, setAge...)<br>
            &nbsp;&nbsp;&nbsp;→ Il convertit la valeur au bon type<br>
            &nbsp;&nbsp;&nbsp;→ Il appelle le setter<br>
            4. L'objet complet est passé à la méthode <code>saveEmploye(Employe emp)</code>
        </p>
    </div>
</body>
</html>
