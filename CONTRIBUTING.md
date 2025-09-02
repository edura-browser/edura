# Contributing to Edura Browser

Thank you for your interest in contributing to Edura Browser! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues
1. **Search existing issues** first to avoid duplicates
2. **Use the issue template** when creating new issues
3. **Provide detailed information**:
   - Operating system and version
   - Steps to reproduce the issue
   - Expected vs actual behavior
   - Screenshots if applicable

### Submitting Changes
1. **Fork the repository**
2. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** following our coding standards
4. **Test your changes** thoroughly
5. **Commit with clear messages**:
   ```bash
   git commit -m "Add: Brief description of your change"
   ```
6. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Create a Pull Request** with a clear description

## 🔧 Development Setup

### Prerequisites
- Windows 10/11
- Visual Studio 2019/2022 with C++ support
- CMake 3.19 or later
- Git

### Building from Source
1. Clone your fork:
   ```bash
   git clone https://github.com/YOUR-USERNAME/edura.git
   cd edura
   ```

2. Build the project:
   ```bash
   cd cef_binary_139.0.28+g55ab8a8+chromium-139.0.7258.139_windows64
   mkdir build
   cd build
   cmake ..
   cmake --build . --config Debug
   ```

3. Test your changes:
   ```bash
   .\tests\cefsimple\Debug\cefsimple.exe
   .\tests\cefclient\Debug\cefclient.exe
   ```

## 📝 Coding Standards

### C++ Code Style
- Follow existing code formatting
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions focused and concise

### Commit Message Format
```
Type: Brief description (50 chars max)

Detailed explanation if needed (wrap at 72 chars)

- Use bullet points for multiple changes
- Reference issues with #issue-number
```

**Types:**
- `Add:` New features
- `Fix:` Bug fixes
- `Update:` Changes to existing features
- `Remove:` Removing code/features
- `Docs:` Documentation changes
- `Style:` Code formatting changes
- `Refactor:` Code restructuring
- `Test:` Adding or updating tests

## 🎯 Areas for Contribution

### High Priority
- **Security enhancements** - Additional browser lockdown features
- **Kiosk mode improvements** - Better Windows integration
- **Performance optimizations** - Faster startup, lower memory usage
- **Documentation** - User guides, API documentation

### Medium Priority
- **Additional platforms** - Linux/macOS support
- **Configuration options** - More customizable settings
- **Accessibility features** - Screen reader support, keyboard navigation
- **Logging and monitoring** - Better diagnostic capabilities

### Low Priority
- **UI enhancements** - Visual improvements
- **Additional languages** - Internationalization
- **Plugin system** - Extensibility framework

## 🧪 Testing

### Before Submitting
1. **Build both Debug and Release** configurations
2. **Test basic functionality**:
   - Application starts without errors
   - Navigation restrictions work
   - Kiosk mode compatibility
   - Installer creates and runs correctly

3. **Test security features**:
   - Links are not clickable
   - Text selection is disabled
   - Context menu is minimal
   - No developer tools access

### Automated Testing
- GitHub Actions will automatically build your changes
- Ensure all checks pass before requesting review

## 📋 Pull Request Guidelines

### Before Creating PR
- [ ] Code builds successfully
- [ ] All tests pass
- [ ] Changes are documented
- [ ] Commit messages follow format
- [ ] Branch is up to date with main

### PR Description Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
- [ ] Tested on Windows 10/11
- [ ] Kiosk mode functionality verified
- [ ] Security restrictions confirmed
- [ ] Installer tested

## Screenshots (if applicable)
Add screenshots to help explain your changes
```

## 🔒 Security Considerations

Since Edura Browser is designed for secure kiosk environments:

1. **Security-first mindset** - Always consider security implications
2. **Test thoroughly** - Security features must work reliably
3. **Document security changes** - Explain impact on security model
4. **No debug features in production** - Keep debug code separate

## 📞 Getting Help

- **GitHub Issues** - For bugs and feature requests
- **GitHub Discussions** - For questions and general discussion

## 📄 License

By contributing to Edura Browser, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for contributing to Edura Browser! 🎉
