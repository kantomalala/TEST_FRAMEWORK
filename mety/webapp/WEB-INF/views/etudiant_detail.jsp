<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails Étudiant - SPRINT 6-TER</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 700px;
            margin: 50px auto;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .card {
            background-color: white;
            border-radius: 15px;
            padding: 40px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }
        .card h1 {
            color: #667eea;
            margin-top: 0;
            border-bottom: 4px solid #667eea;
            padding-bottom: 15px;
        }
        .badge {
            display: inline-block;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .info-box {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            padding: 25px;
            border-radius: 10px;
            margin: 25px 0;
            border-left: 6px solid #667eea;
        }
        .info-box p {
            margin: 12px 0;
            font-size: 17px;
            color: #2c3e50;
        }
        .info-box strong {
            color: #667eea;
            display: inline-block;
            width: 100px;
            font-weight: 600;
        }
        .message {
            background-color: #d4edda;
            color: #155724;
            padding: 18px;
            border-radius: 8px;
            border: 2px solid #c3e6cb;
            margin: 20px 0;
            font-weight: 500;
        }
        .tech-info {
            background-color: #fff3cd;
            border: 2px solid #ffc107;
            color: #856404;
            padding: 15px;
            border-radius: 8px;
            margin: 20px 0;
            font-size: 14px;
        }
        .tech-info code {
            background-color: #fff;
            padding: 2px 8px;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            color: #e83e8c;
        }
        .back-link {
            display: inline-block;
            margin-top: 25px;
            padding: 14px 30px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .back-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <div class="card">
        <h1>🎓 Détails de l'Étudiant</h1>
        <span class="badge">SPRINT 6-TER : Paramètres URL Dynamiques</span>
        
        <div class="message">
            ✅ <%= request.getAttribute("message") %>
        </div>
        
        <div class="info-box">
            <p><strong>ID :</strong> <%= request.getAttribute("id") %></p>
            <p><strong>Nom :</strong> <%= request.getAttribute("nom") %></p>
        </div>
        
        <div class="tech-info">
            <strong>ℹ️ Comment ça marche :</strong><br><br>
            L'ID <strong><%= request.getAttribute("id") %></strong> a été extrait automatiquement depuis l'URL :<br>
            <code>/etudiant/{id}</code><br><br>
            Le framework a détecté <code>@RequestParam("id")</code> et a mappé la valeur dynamique au paramètre de la méthode.
        </div>
        
        <a href="../test_form.html" class="back-link">← Retour aux tests</a>
    </div>
</body>
</html>
