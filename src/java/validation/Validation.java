/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package validation;

/**
 *
 * @author willi
 */
public class Validation {
    public String capFirstLetter(String str){
        String[] words = str.split(" ");
        String result = "";
        for (int i = 0; i < words.length; i++){
            if (words[i].isEmpty()) continue;
            words[i] = words[i].substring(0, 1).toUpperCase() + words[i].substring(1) + " ";
            result += words[i];
        }
        
        return result.trim();
    }
    
    public static void main(String[] args) {
        Validation val = new Validation();
        System.out.println(val.capFirstLetter("h   xin   chao"));
    }
}
