package test.model;

import java.util.Date;

public class Employe {
    private int id;
    private String nom;
    private String email;
    private int age;
    private double salaire;
    private Date dateEmbauche;
    private String poste;
    
    public Employe() {
        // Constructeur par défaut requis pour la réflexion
    }
    
    // Getters et Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNom() {
        return nom;
    }
    
    public void setNom(String nom) {
        this.nom = nom;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public int getAge() {
        return age;
    }
    
    public void setAge(int age) {
        this.age = age;
    }
    
    public double getSalaire() {
        return salaire;
    }
    
    public void setSalaire(double salaire) {
        this.salaire = salaire;
    }
    
    public Date getDateEmbauche() {
        return dateEmbauche;
    }
    
    public void setDateEmbauche(Date dateEmbauche) {
        this.dateEmbauche = dateEmbauche;
    }
    
    public String getPoste() {
        return poste;
    }
    
    public void setPoste(String poste) {
        this.poste = poste;
    }
    
    @Override
    public String toString() {
        return "Employe{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                ", email='" + email + '\'' +
                ", age=" + age +
                ", salaire=" + salaire +
                ", dateEmbauche=" + dateEmbauche +
                ", poste='" + poste + '\'' +
                '}';
    }
}
