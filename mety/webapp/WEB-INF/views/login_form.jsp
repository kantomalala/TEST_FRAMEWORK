<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Connexion - SPRINT 11</title>
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
        
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 50px;
            max-width: 450px;
            width: 100%;
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
        
        h1 {
            color: #667eea;
            margin-bottom: 10px;
            font-size: 2.2em;
            text-align: center;
        }
        
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 40px;
            font-size: 1.1em;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: 600;
        }
        
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 16px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        
        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .login-btn {
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
        
        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
        }
        
        .login-btn:active {
            transform: translateY(0);
        }
        
        .demo-accounts {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-top: 30px;
            border-left: 4px solid #6c757d;
        }
        
        .demo-accounts h3 {
            color: #495057;
            margin-bottom: 15px;
            font-size: 1.1em;
        }
        
        .demo-accounts ul {
            list-style: none;
            padding: 0;
        }
        
        .demo-accounts li {
            background: white;
            padding: 10px 15px;
            margin: 8px 0;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            font-family: monospace;
            font-size: 0.95em;
        }
        
        .info-box {
            background: #e7f3fe;
            border-left: 4px solid #2196F3;
            padding: 20px;
            margin-top: 20px;
            border-radius: 10px;
        }
        
        .info-box strong {
            color: #2196F3;
        }
        
        .back-link {
            text-align: center;
            margin-top: 25px;
        }
        
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
        
        .back-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <span class="sprint-badge">🔐 SPRINT 11 - SESSION LOGIN</span>
        <h1>Connexion</h1>
        <p class="subtitle">Démonstration @SessionParam</p>
        
        <%
            Boolean alreadyLoggedIn = (Boolean) request.getAttribute("alreadyLoggedIn");
            String currentUser = (String) request.getAttribute("currentUser");
            if (alreadyLoggedIn != null && alreadyLoggedIn) {
        %>
        <div style="background: #d1ecf1; padding: 20px; border-left: 4px solid #bee5eb; margin: 20px 0; border-radius: 8px;">
            <h2>✓ Déjà connecté !</h2>
            <p><strong>Bonjour <%= currentUser %> !</strong><br>
            Vous êtes déjà connecté. Que souhaitez-vous faire ?</p>
            <p>
                <a href="<%= request.getContextPath() %>/dashboard" 
                   style="display: inline-block; padding: 12px 25px; background: #28a745; color: white; text-decoration: none; border-radius: 5px; margin: 10px;">
                   → Tableau de bord
                </a>
                <a href="<%= request.getContextPath() %>/auth/logout" 
                   style="display: inline-block; padding: 10px 20px; background: #dc3545; color: white; text-decoration: none; border-radius: 5px;">
                   Déconnexion
                </a>
            </p>
        </div>
        <% } else { %>
        
        <form action="<%= request.getContextPath() %>/auth/login" method="post">
            <div class="form-group">
                <label for="username">Nom d'utilisateur :</label>
                <input type="text" id="username" name="username" placeholder="Entrez votre username" required autofocus>
            </div>
            
            <div class="form-group">
                <label for="password">Mot de passe :</label>
                <input type="password" id="password" name="password" placeholder="Entrez votre mot de passe" required>
            </div>
            
            <button type="submit" class="login-btn">🔑 Se connecter</button>
        </form>
        
        <div class="demo-accounts">
            <h3>Comptes de démonstration :</h3>
            <ul>
                <li><strong>admin</strong> / 123</li>
                <li><strong>user</strong> / pass</li>
                <li><strong>demo</strong> / demo</li>
            </ul>
        </div>
        
        <div class="info-box">
            <strong>💡 Fonctionnement</strong><br>
            1. Saisir identifiants et cliquer "Se connecter"<br>
            2. POST vers /auth/login vérifie les credentials<br>
            3. Si valide : <code>session.setAttribute("currentUser", username)</code><br>
            4. Pages protégées utilisent <code>@SessionParam("currentUser")</code><br>
            5. Si null = pas connecté, sinon = utilisateur connecté
        </div>
        
        <div class="back-link">
            <a href="<%= request.getContextPath() %>/">← Retour à l'accueil</a>
        </div>
        <% } %>
    </div>
    
    <script>
        // Animation d'entrée
        window.addEventListener('load', function() {
            const container = document.querySelector('.login-container');
            container.style.opacity = '0';
            container.style.transform = 'translateY(20px)';
            setTimeout(function() {
                container.style.transition = 'all 0.5s ease';
                container.style.opacity = '1';
                container.style.transform = 'translateY(0)';
            }, 100);
        });
        
        // Auto-fill au click sur les comptes démo
        document.querySelectorAll('.demo-accounts li').forEach(function(li) {
            li.style.cursor = 'pointer';
            li.addEventListener('click', function() {
                const text = this.textContent;
                const parts = text.split(' / ');
                if (parts.length === 2) {
                    document.getElementById('username').value = parts[0];
                    document.getElementById('password').value = parts[1];
                    document.getElementById('password').focus();
                }
            });
        });
        
    </script>
</body>
</html>