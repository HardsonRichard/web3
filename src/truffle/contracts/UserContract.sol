// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

pragma experimental ABIEncoderV2;

contract UserContract {
    //state variable for userIDs
    uint256 userID;

    //state variables for doctors Ids
    uint256 doctorID;

    //state variables for receptionists Ids
    uint256 receptionistID;

    //state variables for nurses Ids
    uint256 nurseID;

    //state variables for laboratory technicians Ids
    uint256 labTechID;

    //state variable for pharmacists Ids
    uint256 pharmacistID;

    //state variable for admin Ids
    uint256 adminID;

    //////////////// STATE VARIABLES END////////////////////////////////

    constructor() {
        userID = 1; //initializes the doctor ID to 1
        receptionistID = 1; //initializes the receptionist ID to 1
        nurseID = 1; //initializes the nurse ID to 1
        labTechID = 1; //initializes the labTech ID to 1
        pharmacistID = 1; //initializes the pharmacist ID to 1
        adminID = 1; //initializes the admin ID to 1
    }

    ////////////// CONSTRUCTOR END ///////////////////////////////////

    ////////////////  ADDRESESS END ////////////////////////////////////

    enum Role {
        Receptionist,
        Nurse,
        Doctor,
        LabTech,
        Pharmacist,
        Admin
    }

    ///////////////// ENUMS END //////////////////////////////////////

    //a mapping for all users
    mapping(address => User) private users;

    //Role specific mappings
    mapping(address => bool) private receptionists;
    mapping(address => bool) private nurses;
    mapping(address => bool) private doctors;
    mapping(address => bool) private labTechs;
    mapping(address => bool) private pharmacists;
    mapping(address => bool) private admins;

    //mapping for role structs
    mapping(uint => Receptionist) private Receptionists;
    mapping(uint => Nurse) private Nurses;
    mapping(uint => Doctor) private Doctors;
    mapping(uint => LabTech) private LabTechs;
    mapping(uint => Pharmacist) private Pharmacists;
    mapping(uint => Admin) private Admins;

    //////////////// MAPPINGS END /////////////////////////////////////

    // An event to show user has been successfully registered
    event RegistrationSuccessful(uint userID, string _userName);

    //an event to show successful login
    event LoggedIn(uint _userID);

    // Event to display user data
    event UserDisplay(
        uint256 userID,
        string userName,
        string email,
        string role
    );

    //////////////// EVENTS END ///////////////////////////////////////

    //modifier to check if the sender is a user
    modifier onlyUser() {
        require(users[msg.sender].userID != 0, "Only users allowed");
        _;
    }

    //modifier to only allow receptionists to do something
    modifier onlyReceptionists() {
        require(
            users[msg.sender].role == Role.Receptionist,
            "Only receptionists allowed"
        );
        _;
    }

    //modifier to only allow nurses to do something
    modifier onlyNurses() {
        require(users[msg.sender].role == Role.Nurse, "Only nurses allowed");
        _;
    }

    //modifier to only allow doctors to do something
    modifier onlyDoctors() {
        require(users[msg.sender].role == Role.Doctor, "Only doctors allowed");
        _;
    }

    //modifier to only allow laboratory technicians to do something
    modifier onlyLabTechs() {
        require(
            users[msg.sender].role == Role.LabTech,
            "Only laboratory technicians allowed"
        );
        _;
    }

    //modifier to only allow pharmacists to do something
    modifier onlyPharmacists() {
        require(
            users[msg.sender].role == Role.Pharmacist,
            "Only pharmacists allowed"
        );
        _;
    }

    //modifier to only allow admins to do something
    modifier onlyAdmins() {
        require(users[msg.sender].role == Role.Admin, "Only admins allowed");
        _;
    }

    ////////////// MODIFIERS END /////////////////////////////////////

    //struct for all users
    struct User {
        uint userID;
        string userName;
        string email;
        bytes32 password;
        Role role;
    }

    //struct for receptionists
    struct Receptionist {
        uint receptionistID;
        string receptionistName;
    }

    //struct for nurses
    struct Nurse {
        uint nurseID;
        string nurseName;
    }

    //struct for doctors
    struct Doctor {
        uint doctorID;
        string doctorName;
    }

    //struct for laboratory technician
    struct LabTech {
        uint labTechID;
        string labTechName;
    }

    //struct for pharmacists
    struct Pharmacist {
        uint pharmacistID;
        string pharmacistName;
    }

    struct Admin {
        uint adminID;
        string adminName;
    }

    ///////////////// STRUCTS END /////////////////////////////////////

    function register(
        string memory _userName,
        string memory _email,
        string memory _password,
        Role _role
    ) public {
        bytes32 _passwordHash = keccak256(abi.encodePacked(_password));

        users[msg.sender] = User({
            userID: userID,
            userName: _userName,
            email: _email,
            password: _passwordHash,
            role: _role
        });

        // Update role-specific mappings
        if (_role == Role.Receptionist) {
            receptionists[msg.sender] = true;
            Receptionists[receptionistID] = Receptionist({
                receptionistID: receptionistID,
                receptionistName: _userName
            });
            receptionistID++;
        } else if (_role == Role.Nurse) {
            nurses[msg.sender] = true;
            Nurses[nurseID] = Nurse({nurseID: nurseID, nurseName: _userName});
            nurseID++;
        } else if (_role == Role.Doctor) {
            doctors[msg.sender] = true;
            Doctors[doctorID] = Doctor({
                doctorID: doctorID,
                doctorName: _userName
            });
            doctorID++;
        } else if (_role == Role.LabTech) {
            labTechs[msg.sender] = true;
            LabTechs[labTechID] = LabTech({
                labTechID: labTechID,
                labTechName: _userName
            });
            labTechID++;
        } else if (_role == Role.Pharmacist) {
            pharmacists[msg.sender] = true;
            Pharmacists[pharmacistID] = Pharmacist({
                pharmacistID: pharmacistID,
                pharmacistName: _userName
            });
            pharmacistID++;
        } else if (_role == Role.Admin) {
            admins[msg.sender] = true;
            Admins[adminID] = Admin({adminID: adminID, adminName: _userName});
            adminID++;
        }
        userID++;

        emit RegistrationSuccessful(userID, _userName);
    }

    //function allow user to login in to the system
    function login(
        string memory _email,
        string memory _password
    ) public view returns (User) {
        bytes32 passwordHash = keccak256(abi.encodePacked(_password));
        User memory _user = users[msg.sender];
        if (
            keccak256(abi.encodePacked(_user.email)) ==
            keccak256(abi.encodePacked(_email)) &&
            keccak256(abi.encodePacked(_user.password)) ==
            keccak256(abi.encodePacked(passwordHash))
        ) {
            return _user;
        }
    }

    //////////////////// FUNCTIONS END //////////////////////////////////
}
