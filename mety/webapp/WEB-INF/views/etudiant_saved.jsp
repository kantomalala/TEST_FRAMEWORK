<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Résultat - Étudiant Enregistré</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .success-box {
            background-color: #d4edda;
            border: 2px solid #28a745;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
        }
        .success-box h1 {
            color: #28a745;
            margin-top: 0;
        }
        .success-box p {
            color: #155724;
            font-size: 16px;
            margin: 10px 0;
        }
        .data {
            background-color: white;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
            text-align: left;
        }
        .data strong {
            color: #333;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-link:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="success-box">
        <h1>✅ Succès !</h1>
        <p><%= request.getAttribute("message") %></p>
        
        <div class="data">
            <p><strong>ID :</strong> <%= request.getAttribute("id") %></p>
            <p><strong>Nom :</strong> <%= request.getAttribute("nom") %></p>
        </div>
        
        <a href="test_form.html" class="back-link">← Retour au formulaire</a>
    </div>
</body>
</html>
