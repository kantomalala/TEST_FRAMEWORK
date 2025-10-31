package test.urlAnnotations;

import framework.Annotation.Url;

public class UrlController {
    @Url("/test1")
    public void voaloha() {
        System.out.println("hello");
    }

    @Url("/test2")
    public void deuxieme() {
        System.out.println("ca va");
    }

    @Url("/test3")
    public void hiiii(){
        System.out.println("bye");
    }

    public void sayHi() {}
}