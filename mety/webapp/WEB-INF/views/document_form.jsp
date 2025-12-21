<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload de Document - SPRINT 10</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            padding: 40px;
        }
        
        h1 {
            color: #667eea;
            border-bottom: 3px solid #667eea;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }
        
        .sprint-badge {
            background: #667eea;
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.9em;
            display: inline-block;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: 600;
        }
        
        input[type="text"],
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #e0e0e0;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s;
        }
        
        input[type="text"]:focus,
        textarea:focus {
            outline: none;
            border-color: #667eea;
        }
        
        input[type="file"] {
            padding: 10px;
            background: #f8f9fa;
            cursor: pointer;
        }
        
        textarea {
            resize: vertical;
            min-height: 100px;
        }
        
        button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-top: 20px;
        }
        
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        
        button:active {
            transform: translateY(0);
        }
        
        .info-box {
            background: #e7f3fe;
            border-left: 4px solid #2196F3;
            padding: 15px;
            margin-top: 30px;
            border-radius: 5px;
        }
        
        .info-box strong {
            color: #2196F3;
        }
        
        .file-info {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 15px;
            margin-top: 15px;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <span class="sprint-badge">SPRINT 10</span>
        <h1><%= request.getAttribute("titre") %></h1>
        
        <form action="<%= request.getContextPath() %>/document/upload" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="titre">Titre du document :</label>
                <input type="text" id="titre" name="titre" placeholder="Ex: Rapport de projet" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description :</label>
                <textarea id="description" name="description" placeholder="Brève description du document..." required></textarea>
            </div>
            
            <div class="form-group">
                <label for="fichier">Fichier à uploader :</label>
                <input type="file" id="fichier" name="fichier" required>
            </div>
            
            <div class="file-info">
                <strong>⚠ Note :</strong> Le fichier sera sauvegardé dans <code>C:\temp\uploads\</code>
            </div>
            
            <button type="submit">📤 Uploader le Document</button>
        </form>
        
        <div class="info-box">
            <strong>💡 Comment ça fonctionne ?</strong><br>
            • Le formulaire utilise <code>enctype="multipart/form-data"</code><br>
            • Le FrontServlet détecte automatiquement le paramètre <code>UploadedFile</code><br>
            • Les bytes du fichier sont extraits et injectés dans le controller<br>
            • Vous pouvez ensuite sauvegarder le fichier avec <code>fichier.saveTo(path)</code>
        </div>
        
        <a href="<%= request.getContextPath() %>/" class="back-link">← Retour à l'accueil</a>
    </div>
</body>
</html>
