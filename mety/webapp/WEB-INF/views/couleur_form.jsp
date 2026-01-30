<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Couleur Préférée - SPRINT 11</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 50px;
            max-width: 600px;
            width: 100%;
        }
        
        h1 {
            color: #667eea;
            margin-bottom: 10px;
            font-size: 2.5em;
        }
        
        .sprint-badge {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 0.9em;
            display: inline-block;
            margin-bottom: 30px;
            font-weight: 600;
        }
        
        .color-preview {
            width: 100%;
            height: 250px;
            border-radius: 15px;
            margin: 30px 0;
            border: 4px solid #e0e0e0;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 10px;
            color: #333;
            font-weight: 600;
            font-size: 1.1em;
        }
        
        input[type="color"] {
            width: 100%;
            height: 60px;
            border: 3px solid #e0e0e0;
            border-radius: 10px;
            cursor: pointer;
            transition: border-color 0.3s;
        }
        
        input[type="color"]:hover {
            border-color: #667eea;
        }
        
        .color-code {
            text-align: center;
            font-size: 1.5em;
            font-weight: bold;
            color: #555;
            margin-top: 15px;
            font-family: 'Courier New', monospace;
        }
        
        button {
            width: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 18px;
            border: none;
            border-radius: 10px;
            font-size: 1.2em;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            margin-top: 20px;
        }
        
        button:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }
        
        button:active {
            transform: translateY(0);
        }
        
        .info-box {
            background: #f0f7ff;
            border-left: 5px solid #2196F3;
            padding: 20px;
            margin-top: 30px;
            border-radius: 10px;
            line-height: 1.8;
        }
        
        .info-box strong {
            color: #2196F3;
            font-size: 1.1em;
        }
        
        .current-saved {
            background: #e8f5e9;
            border-left: 5px solid #4caf50;
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 8px;
        }
        
        .current-saved strong {
            color: #4caf50;
        }
        
        code {
            background: #f5f5f5;
            padding: 3px 8px;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            color: #e83e8c;
        }
    </style>
</head>
<body>
    <div class="container">
        <span class="sprint-badge">🎨 SPRINT 11 - SESSION + COOKIES</span>
        <h1><%= request.getAttribute("titre") %></h1>
        
        <% 
            String couleurActuelle = (String) request.getAttribute("couleurActuelle");
            if (couleurActuelle != null && !couleurActuelle.equals("#3498db")) {
        %>
        <div class="current-saved">
            <strong>✓ Couleur sauvegardée trouvée !</strong><br>
            Votre préférence : <code><%= couleurActuelle %></code><br>
            <small>Chargée depuis la session ou le cookie</small>
        </div>
        <% } %>
        
        <form action="<%= request.getContextPath() %>/preferences/couleur" method="post">
            <div class="form-group">
                <label for="couleur">Choisissez votre couleur préférée :</label>
                <input type="color" 
                       id="couleur" 
                       name="couleur" 
                       value="<%= couleurActuelle %>"
                       onchange="updatePreview(this.value)">
                <div class="color-code" id="colorCode"><%= couleurActuelle %></div>
            </div>
            
            <div class="color-preview" id="preview" style="background-color: <%= couleurActuelle %>;"></div>
            
            <button type="submit">💾 Sauvegarder ma couleur</button>
        </form>
        
        <div class="info-box">
            <strong>💡 Démonstration @SessionParam</strong><br>
            • La couleur est lue via <code>@SessionParam("couleurPreferee")</code><br>
            • Si session vide, on restaure depuis le <strong>cookie</strong><br>
            • À la sauvegarde : stockage en <strong>session + cookie (30 jours)</strong><br>
            • Fermez le navigateur et revenez : votre couleur sera là !<br>
            • Testez aussi dans un autre navigateur avec le même cookie
        </div>
    </div>
    
    <script>
        function updatePreview(color) {
            document.getElementById('preview').style.backgroundColor = color;
            document.getElementById('colorCode').textContent = color.toUpperCase();
        }
        
        // Animation d'entrée
        window.addEventListener('load', function() {
            document.querySelector('.container').style.opacity = '0';
            document.querySelector('.container').style.transform = 'translateY(30px)';
            setTimeout(function() {
                document.querySelector('.container').style.transition = 'all 0.5s ease';
                document.querySelector('.container').style.opacity = '1';
                document.querySelector('.container').style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>
