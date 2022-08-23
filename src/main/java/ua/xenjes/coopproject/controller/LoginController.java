package ua.xenjes.coopproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import ua.xenjes.coopproject.entity.AppUser;
import ua.xenjes.coopproject.service.AppUserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Objects;

@Controller
public class LoginController {

    private final AppUserService appUserService;

    @Autowired
    public LoginController(AppUserService appUserService){
        this.appUserService = appUserService;
    }

    @GetMapping("/signup")
    public String signUpPage(HttpServletRequest request){
        HttpSession session = request.getSession();
        AppUser appUser = (AppUser) session.getAttribute("appuser");
        if (Objects.isNull(appUser)){
            return "signup";
        }else {
            return "redirect:/hub";
        }
    }

    @PostMapping("/signup")
    public String signUpUser(AppUser appUser,
                             Model model){
        if (!appUserService.checkUserByUsername(appUser.getUsername())){
            appUserService.registerNewUser(appUser);
            return "redirect:/login";
        }else {
            model.addAttribute("errorSignUp", 1);
            return "signup";
        }
    }

    @GetMapping("/login")
    public String loginPage(){
        return "login";
    }

    @PostMapping("/login")
    public String loginUser(AppUser appUser,
                            HttpServletRequest request,
                            Model model){
        if (appUserService.checkUserByUsernameAndPassword(appUser.getUsername(), appUser.getPassword())){
            HttpSession session = request.getSession();
            session.setAttribute("appuser", appUserService.getAppUserByUsername(appUser.getUsername()));
            return "redirect:/hub";
        }else {
            model.addAttribute("errorLogin", 1);
            return "login";
        }
    }

    @PostMapping("/logout")
    public String logoutUser(HttpServletRequest request){
        HttpSession session = request.getSession();
        AppUser appUser = (AppUser) session.getAttribute("appuser");
        if (Objects.isNull(appUser)){
            return "redirect:/login";
        }else {
            session.removeAttribute("appuser");
            return "redirect:/";
        }
    }

}
