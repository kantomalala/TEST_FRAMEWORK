package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;

@Controller
public class UrlController {

    @Url("/test1")
<<<<<<< Updated upstream
    public void voaloha() {
        System.out.println("hello");
    }

    @Url("/test2")
    public void deuxieme() {
        System.out.println("ca va");
    }

    @Url("/test3")
    public void hiiii() {
        System.out.println("bye");
    }

    public void sayHi() {
        System.out.println("hi");
=======
    public void hello() {
        System.out.println("Hello from /test1");
    }

    @Url("/test2")
    public void bye() {
        System.out.println("Bye from /test2");
>>>>>>> Stashed changes
    }
}