package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;

@Controller
public class UrlController {

    @Url("/test1")
    public void hello() {
        System.out.println("Hello from /test1");
    }

    @Url("/test2")
    public void bye() {
        System.out.println("Bye from /test2");
    }
}