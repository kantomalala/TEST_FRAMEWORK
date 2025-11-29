<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>${titre}</title>
</head>
<body>
    <h1>${titre}</h1>
    
    <form action="save" method="post">
        <p>
            <label>ID : </label>
            <input type="text" name="id" value="101"/>
        </p>
        <p>
            <label>Nom : </label>
            <input type="text" name="nom" value="RAKOTO Jean"/>
        </p>
        <p>
            <button type="submit">Enregistrer</button>
        </p>
    </form>
    
    <p><em>SPRINT 7 : GET affiche ce formulaire, POST le traite</em></p>
</body>
</html>
