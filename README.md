# TW

### To get API access:
- Retrieve API private Key: https://developer.teamwork.com/introduction#so_how_do_you_get
- Add new environment variable with name `USER_PRIVATE_KEY` and for the value input the private key retrieved in previous step.

### To Run FBSnapshotTestCases:
- Add variable with name `FB_REFERENCE_IMAGE_DIR` and for the value `$(SOURCE_ROOT)/$(PROJECT_NAME)Tests/ReferenceImages`
- Add variable with name `IMAGE_DIFF_DIR` and for the value `$(SOURCE_ROOT)/$(PROJECT_NAME)Tests/FailureDiffs`
- Use iPhone 8 Plus to test (other devices will fail because they have different screen size)

