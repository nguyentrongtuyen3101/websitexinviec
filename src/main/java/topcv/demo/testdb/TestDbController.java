package topcv.demo.testdb;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.sql.DataSource;
import java.sql.Connection;

@Controller
@RequestMapping("/testdbtopcv")
public class TestDbController {

    private final DataSource dataSource;

    public TestDbController(DataSource dataSource) {
        this.dataSource = dataSource;
        System.out.println("TestDbController initialized with DataSource: " + dataSource);
    }

    @GetMapping
    @ResponseBody
    public String testDb() {
        try {
            Connection myConn = dataSource.getConnection();
            String result = "Connecting to database: " + dataSource + "\nSUCCESS!!! hehehehe";
            myConn.close();
            return result;
        } catch (Exception exc) {
            exc.printStackTrace();
            return "Failed to connect to database: " + exc.getMessage();
        }
    }

    @GetMapping("/hello")
    @ResponseBody
    public String hello() {
        return "Hello, Spring is working!";
    }
}