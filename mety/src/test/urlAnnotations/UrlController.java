package test.urlAnnotations;

import framework.Annotation.Controller;
import framework.Annotation.Url;

@Controller
public class UrlController {

    @Url("/test1")
    public String hello() {
        return "hello";
    }

    @Url("/test2")
    public String bye() {
        return "bye";
    }
}