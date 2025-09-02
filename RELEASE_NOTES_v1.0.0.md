# Edura Browser v1.0.0 Release Notes

**Release Date:** January 25, 2025  
**Version:** 1.0.0  
**Build:** Based on CEF 139.0.28 + Chromium 139.0.7258.139

---

## 🎉 **Initial Release - Secure Kiosk Browser**

We're excited to announce the first release of **Edura Browser**, a secure, kiosk-ready browser application designed for controlled browsing environments. Built on the robust Chromium Embedded Framework (CEF), Edura Browser provides enterprise-grade security with professional branding.

---

## 🚀 **What's New**

### 🔒 **Enterprise Security Features**
- **Link Navigation Blocking** - Users cannot click hyperlinks to navigate away from intended content
- **Text Selection Disabled** - Prevents copying of sensitive information from web pages
- **Context Menu Lockdown** - Minimal right-click menu with no customization options
- **Popup Window Blocking** - All popup windows are completely blocked
- **Developer Tools Removed** - No access to debugging, inspection, or technical features

### 🖥️ **Kiosk Mode Ready**
- **Windows Kiosk Integration** - Seamless compatibility with Windows Assigned Access
- **URL Parameter Support** - Launch with custom URLs: `cefsimple.exe --url=https://your-site.com`
- **Clean Interface** - No toolbars, address bars, or user-accessible controls
- **Professional Branding** - Custom Edura icons and consistent window titles

### ⚙️ **Flexible Deployment Options**
- **Address Bar Navigation** - Administrators can type URLs directly (cefclient version)
- **Search Engine Support** - Google search and form inputs work normally
- **Redirect Handling** - Automatic redirects function properly
- **Local Content Support** - Can display local HTML files and web applications

---

## 📦 **What's Included**

### **Two Browser Applications**

#### **cefsimple.exe** - Production Kiosk Browser
- **Purpose:** Secure deployment in kiosk environments
- **Security:** Maximum lockdown with all restrictions active
- **Interface:** Minimal, clean design with no user controls
- **Usage:** `cefsimple.exe --url=https://your-company-portal.com`

#### **cefclient.exe** - Development & Testing Browser
- **Purpose:** Development, testing, and administrative use
- **Features:** Full browser controls, address bar, developer options
- **Flexibility:** Complete CEF feature set for testing and configuration
- **Usage:** `cefclient.exe --url=https://your-site.com`

### **Professional Installer**
- **Windows Installer** - Professional MSI-style installation via Inno Setup
- **Automatic Dependencies** - Includes all required CEF runtime libraries
- **Start Menu Integration** - Professional shortcuts with custom Edura icons
- **Clean Uninstall** - Complete removal of all files and registry entries
- **Administrator Installation** - Proper system-wide deployment

---

## 🎯 **Key Use Cases**

### **Kiosk Deployments**
- **Public Information Terminals** - Libraries, museums, retail locations
- **Corporate Portals** - Employee self-service stations
- **Digital Signage** - Interactive displays and information boards
- **Educational Environments** - Controlled browsing for students

### **Controlled Browsing**
- **Healthcare Terminals** - Patient check-in and information systems
- **Government Services** - Public access terminals for citizen services
- **Retail Applications** - Product catalogs and customer information
- **Conference Systems** - Event information and registration terminals

---

## 🔧 **Technical Specifications**

### **System Requirements**
- **Operating System:** Windows 10/11 (64-bit)
- **Memory:** 4GB RAM minimum, 8GB recommended
- **Storage:** 500MB available disk space
- **Network:** Internet connection for web content

### **Built With**
- **CEF Version:** 139.0.28+g55ab8a8
- **Chromium Version:** 139.0.7258.139
- **Compiler:** Visual Studio 2022
- **Framework:** Native Windows with CEF Views

### **Security Architecture**
- **Process Isolation** - Multi-process architecture for stability
- **Sandboxed Rendering** - Chromium's security sandbox active
- **Network Restrictions** - Configurable URL filtering capabilities
- **Memory Protection** - Modern Windows security features enabled

---

## 📋 **Installation & Deployment**

### **Quick Installation**
1. Download `EduraBrowserSetup.exe` from the releases page
2. Run installer as Administrator
3. Follow installation wizard
4. Launch from Start Menu or Desktop shortcut

### **Kiosk Mode Setup**
1. Install Edura Browser using the installer
2. Open Windows Settings → Accounts → Family & other users
3. Select "Set up a kiosk" → "Assigned access"
4. Choose Edura Browser (`cefsimple.exe`)
5. Configure startup URL if needed

### **Command Line Options**
```bash
# Open specific website
cefsimple.exe --url=https://your-company-portal.com

# Open local HTML file
cefsimple.exe --url=file:///C:/kiosk/content/index.html

# Default behavior (opens Google)
cefsimple.exe
```

---

## 🛠️ **For Developers**

### **Source Code**
- **Repository:** https://github.com/Mooo0042/edura
- **License:** Proprietary (Mod-Sauce) with CEF BSD components
- **Build System:** CMake with Visual Studio
- **Documentation:** Complete README and contributing guidelines

### **Customization Points**
- **Default URL** - Modify startup page in source code
- **Security Policies** - Adjust navigation and content restrictions
- **Branding** - Replace icons and window titles
- **Feature Set** - Enable/disable specific browser capabilities

---

## 📞 **Support & Resources**

### **Documentation**
- **User Guide** - Complete setup and usage instructions in README.md
- **Developer Docs** - Source code documentation and build instructions
- **Kiosk Setup Guide** - Windows Assigned Access configuration

### **Getting Help**
- **GitHub Issues** - Bug reports and feature requests
- **Email Support** - Technical support for deployment issues
- **Community** - GitHub Discussions for questions and tips

---

## 🔮 **What's Next**

### **Planned Features (Future Releases)**
- **Enhanced URL Filtering** - Domain whitelist/blacklist capabilities
- **Remote Management** - Centralized configuration and monitoring
- **Additional Platforms** - Linux and macOS support
- **Advanced Kiosk Features** - Session timeouts and automatic resets

### **Contributing**
We welcome contributions! See `CONTRIBUTING.md` for guidelines on:
- Reporting bugs and requesting features
- Submitting code improvements
- Documentation updates
- Security enhancements

---

## 📄 **License & Legal**

**Edura Browser** is Copyright (C) 2025 Mod-Sauce. All rights reserved.

This software includes components from the Chromium Embedded Framework (CEF), which is subject to the BSD license. See included license files for complete terms.

---

## 🎯 **Download**

**[Download Edura Browser v1.0.0](https://github.com/Mooo0042/edura/releases/tag/v1.0.0)**

- `EduraBrowserSetup.exe` - Windows Installer (Recommended)
- `EduraBrowser-v1.0.0.zip` - Portable Version
- `Source Code` - Complete source code archive

---

**Thank you for choosing Edura Browser for your secure browsing needs!** 🎉

*For questions or support, please visit our [GitHub repository](https://github.com/Mooo0042/edura) or contact support.*
