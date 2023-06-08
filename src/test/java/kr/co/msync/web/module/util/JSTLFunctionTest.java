package kr.co.msync.web.module.util;


import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
        locations = {
                "classpath:application-context.xml",
                "classpath:prop-context.xml"
        }
)
@WebAppConfiguration
public class JSTLFunctionTest {
    @Test
    public void getStoreSelectBoxTest(){
        String inclusive_code = "05";
        String result = JSTLFunction.getStoreSelectBox("store_type", "Y", "store_type",true, "", inclusive_code);
        System.out.println("==============================================================================================");
        System.out.println(result);
        System.out.println("==============================================================================================");
    }
}
