package dto;

public class UserDTO {

    private int userId;
    private String fullname;
    private String email;
    private String phone; // Chuyển về String để tương thích với nvarchar
    private String username;
    private String password;
    private String address;
    private String role;   // Không được phép nhập

    public UserDTO(int userId, String fullname, String email, String phone, String username, String password, String address, String role) {
        this.userId = userId;
        this.fullname = fullname;
        this.email = email;
        this.phone = phone; // phone là String
        this.username = username;
        this.password = password;
        this.address = address;
        this.role = role;
    }

    public UserDTO() {
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone; // phone là String
    }

    public void setPhone(String phone) {
        this.phone = phone; // phone là String
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
    
}
