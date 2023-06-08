package kr.co.msync.web.module.util;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

public class FileUtil {

    @Value("#{config['aws.bucket.name']}")
    private String BUCKET_NAME;

    @Value("#{config['aws.access.key']}")
    private String ACCESS_KEY;

    @Value("#{config['aws.secret.key']}")
    private String SECRET_KEY;

    private AmazonS3 amazonS3;

    public FileUtil() {
        AWSCredentials awsCredentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
        amazonS3 = new AmazonS3Client(awsCredentials);
    }

    /**
     * Method Desc : 파일 업로드(widht, height 구하기)
     * @param file
     * @param fileName
     * @return
     * @throws Exception
     */
    public static Map fileUpload(MultipartFile file, String fileName) {
        Map map = new HashMap<String, Object>();
        boolean isResult = false;
        int width = 0;
        int height = 0;
        try {
            File f = new File(fileName);
            file.transferTo(f);
            BufferedImage bi = ImageIO.read(f);
            if(bi!=null){
                width = bi.getWidth();
                height = bi.getHeight();
            }
            map.put("width",width);
            map.put("height",height);
            isResult = true;
        } catch (Exception e) {
            e.printStackTrace();
            isResult = false;
        }
        map.put("isResult", isResult);
        return map;
    }

    public boolean uploadFile(File file) {

        boolean result = false;

        if (amazonS3 != null) {
            try {
                PutObjectRequest putObjectRequest =
                        new PutObjectRequest(BUCKET_NAME + "/sub_dir_name"/*sub directory*/, file.getName(), file);
                putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead); // file permission
                amazonS3.putObject(putObjectRequest); // upload file
                result = true;
            } catch (AmazonServiceException ase) {
                result = false;
            } finally {
                amazonS3 = null;
            }
        }

        return result;
    }

}
