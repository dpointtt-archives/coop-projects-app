package ua.xenjes.coopproject.bl;

import java.security.SecureRandom;
import java.util.Base64;

public class ProjectCodeGenerator {
    private static final SecureRandom secureRandom = new SecureRandom(); //threadsafe
    private static final Base64.Encoder base64Encoder = Base64.getUrlEncoder(); //threadsafe

    public static String generateNewCode() {
        byte[] randomBytes = new byte[8];
        secureRandom.nextBytes(randomBytes);
        return base64Encoder.encodeToString(randomBytes);
    }

}
