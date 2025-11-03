package test.urlAnnotations;

import framework.annotations.Controller;
import framework.annotations.Url;

@Controller
public class UrlController {

    @Url("/test1")
    public void voaloha() { }

    @Url("/test2")
    public void deuxieme() { }

    public void sayHi() { }
}