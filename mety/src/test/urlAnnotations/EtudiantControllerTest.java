package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;
import framework.util.ModelView;

@Controller
public class EtudiantControllerTest {

    @Url("/etudiant/save")
    public ModelView save(int id, String nom) {
        System.out.println("TEST: EtudiantControllerTest.save()");
        System.out.println("  ID = " + id);
        System.out.println("  NOM = " + nom);
        
        ModelView mv = new ModelView("test_result");
        mv.addAttribute("id", id);
        mv.addAttribute("nom", nom);
        mv.addAttribute("success", true);
        
        return mv;
    }

    @Url("/etudiant/list")
    public String list(int page) {
        System.out.println("TEST: EtudiantControllerTest.list()");
        System.out.println("  PAGE = " + page);
        
        return "Page " + page + " affichée";
    }

    @Url("/etudiant/{id}")
    public ModelView getById(int id) {
        System.out.println("TEST: EtudiantControllerTest.getById()");
        System.out.println("  ID = " + id);
        
        ModelView mv = new ModelView("test_detail");
        mv.addAttribute("id", id);
        
        return mv;
    }
}
