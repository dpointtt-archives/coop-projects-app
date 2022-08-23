package ua.xenjes.coopproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.xenjes.coopproject.entity.AppUser;
import ua.xenjes.coopproject.repository.AppUserRepository;

@Service
public class AppUserService {

    private final AppUserRepository appUserRepository;

    @Autowired
    public AppUserService(AppUserRepository appUserRepository){
        this.appUserRepository = appUserRepository;
    }

    public void registerNewUser(String username, String password){
        AppUser appUser = new AppUser(username, password);
        appUserRepository.save(new AppUser(username, password));
    }

    public void registerNewUser(AppUser appUser){
        appUserRepository.save(appUser);
    }

    public boolean checkUserByUsername(String username){
        return appUserRepository.existsAppUserByUsername(username);
    }

    public boolean checkUserByUsernameAndPassword(String username, String password){
        return appUserRepository.existsAppUserByUsernameAndPassword(username, password);
    }

    public AppUser userById(Long id){
        return appUserRepository.getAppUserById(id);
    }

    public AppUser getAppUserByUsername(String username){
        return appUserRepository.findByUsername(username);
    }

}
