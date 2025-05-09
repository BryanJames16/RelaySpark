# 🤝 Contributing Guidelines

Thank you for your interest in contributing to this project! There are many ways to contribute to the project. You can:

1. [✍️ File a new issue, bug report, or feature request.](https://github.com/BryanJames16/RelaySpark/issues)
2. [👷🏼‍♂️ Create a new supported job or update existing ones.](#creating-new-job)
3. [📖 Improve documentation.](#improve-documentation)

To keep things clean and consistent, we have contributing guidelines depending on the type of contribution you want to apply.

---

## Creating New Job

### 1️⃣ Fork the Repository
Begin by forking this repository to your personal GitHub account.
Clone your forked version locally using:

```bash
git clone https://github.com/BryanJames16/RelaySpark.git
cd <repo-name>
```

### 2️⃣ Locate the Correct File to Update
Depending on the type of job you're adding or updating, navigate to the appropriate .mk file:

| File | Description |
| ----------- | ----------- |
| [pipeline.mk](./pipeline.mk) | Include annotations for all pipeline files |
| [Core/build.mk](./Core/build.mk) | Build jobs for all kinds of applications. |
| [Core/clean.mk](./Core/clean.mk) | Jobs for performing project clean up. |
| [Core/publish.mk](./Core/publish.mk) | Jobs for publishing artifacts. |
| [Core/security.mk](./Core/security.mk) | Security jobs for scanning and compliance. |
| [Core/startup.mk](./Core/startup.mk) | Basic startup jobs and configuration for pipelines. |
| [Core/test.mk](./Core/test.mk) | Jobs for performing testing of all kinds except security. |
| [Helper/clean.mk](./Helper/defaults.mk) | Default variable values. |

### 3️⃣ Add / Update Jobs

Each job consists of two parts:
- The container calling job (uses container pattern).
- The script execution job (actual logic).

Add or update both jobs to the appropriate .mk file using the following template:
```Makefile
.PHONY: <container-call-job>
<container-call-job>:
	$(CONTAINER_COMMAND_BASE) $(CONTAINER_COMMAND_PARAMETER) $(CONTAINER_COMMAND_SERVICE) $(MAKE) _<script-job>

.PHONY: _<script-job>
_<script-job>:
	@echo "Running <script description>..."
	<your-command-1>
	<your-command-2>
	@echo "Completed <script description>!"

```

Note that the `script_job` should always start with underscore `_` as part of naming convention.

### 4️⃣ Add or Update Documentation to the Calling Job
Add or update the following block above the container-calling job for proper documentation:

```Makefile
##
# @function     <container-call-job>
# @brief        <One-line summary of the job's purpose>
# @param[in]    <VAR_1>  <Description of VAR_1>
# @param[in]    <VAR_2>  <Description of VAR_2>
# @param[in]    <VAR_3>  <Description of VAR_3>
##
```

### 5️⃣ Add or Update Default Variables to `Helper/defaults.mk`
Define your job-specific default variables inside Helper/defaults.mk.

Organize them under an appropriate section header, or create a new section if one doesn't exist. For example:

```Makefile
## <Job Description>
VARIABLE_1      ?=
VARIABLE_2      ?=
VARIABLE_3      ?=
```

### 6️⃣ Submit Your Pull Request
Once you've added your jobs and documentation, commit your changes and push to your forked branch.
Then open a Pull Request (PR) back to the main repository.

Please follow any PR templates and checklists provided.

---

## Improve Documentation

### 1️⃣ Fork the Repository
Begin by forking this repository to your personal GitHub account.
Clone your forked version locally using:

```bash
git clone https://github.com/BryanJames16/RelaySpark.git
cd <repo-name>
```

### 2️⃣ Add or Update Comments
Add or update existing comments to job. Fix any typos. Add links. Make it a little bit more descriptive but still concise.

### 3️⃣ Add Markdown Docs
Create or update files under the `Docs/` folder.
