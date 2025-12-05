# # R Package Installation Script for MENTHU
# # This script installs all required packages with correct versions

# # Function to safely check if package exists and get version
# safe_package_check <- function(pkg) {
#   tryCatch({
#     if (require(pkg, character.only = TRUE, quietly = TRUE)) {
#       return(list(installed = TRUE, version = as.character(packageVersion(pkg))))
#     } else {
#       return(list(installed = FALSE, version = NA))
#     }
#   }, error = function(e) {
#     return(list(installed = FALSE, version = NA))
#   })
# }

# # Function to force install package (handles "in use" packages)
# force_install <- function(pkg, bioc = FALSE) {
#   cat("Installing package:", pkg, "\n")
#   tryCatch({
#     if (bioc) {
#       BiocManager::install(pkg, force = TRUE, quiet = FALSE)
#     } else {
#       # Try installing with force update
#       install.packages(pkg, dependencies = TRUE, repos = "https://cran.r-project.org", force = TRUE)
#     }
    
#     # Verify installation
#     check <- safe_package_check(pkg)
#     if (check$installed) {
#       cat("✓ Successfully installed", pkg, "version", check$version, "\n")
#       return(TRUE)
#     } else {
#       cat("✗ Failed to install", pkg, "\n")
#       return(FALSE)
#     }
#   }, error = function(e) {
#     cat("✗ Error installing", pkg, ":", e$message, "\n")
#     return(FALSE)
#   })
# }

# # Core packages required for MENTHU (prioritized list)
# core_packages <- c("shiny", "promises", "htmltools")
# secondary_packages <- c("shinyjs", "Rcpp", "plyr", "stringr", "stringi", 
#                        "rentrez", "rlist", "DT", "rhandsontable", "httr", "jsonlite", "xml2")

# # Note: Skipping problematic packages: shinyTable (not available for R 4.3+), 
# # devtools (dependency issues), xlsx (Java dependency issues)

# cat("=== Installing Core Packages for MENTHU ===\n")

# # Install BiocManager first if not available
# if (!safe_package_check("BiocManager")$installed) {
#   install.packages("BiocManager", repos = "https://cran.r-project.org")
# }

# # Install core packages first
# for (pkg in core_packages) {
#   check <- safe_package_check(pkg)
#   if (!check$installed) {
#     force_install(pkg)
#   } else {
#     # Check if version is adequate for critical packages
#     if (pkg == "promises" && check$version < "1.5.0") {
#       cat("Updating", pkg, "from", check$version, "to latest version\n")
#       force_install(pkg)
#     } else if (pkg == "htmltools" && check$version < "0.5.4") {
#       cat("Updating", pkg, "from", check$version, "to latest version\n") 
#       force_install(pkg)
#     } else {
#       cat("✓", pkg, "version", check$version, "is adequate\n")
#     }
#   }
# }

# # Install Biostrings
# cat("\n=== Installing Bioconductor Packages ===\n")
# biostrings_check <- safe_package_check("Biostrings")
# if (!biostrings_check$installed) {
#   force_install("Biostrings", bioc = TRUE)
# } else {
#   cat("✓ Biostrings version", biostrings_check$version, "already installed\n")
# }

# # Install secondary packages (non-critical)
# cat("\n=== Installing Secondary Packages ===\n")
# for (pkg in secondary_packages) {
#   check <- safe_package_check(pkg)
#   if (!check$installed) {
#     cat("Installing optional package:", pkg, "\n")
#     tryCatch({
#       install.packages(pkg, dependencies = TRUE, repos = "https://cran.r-project.org")
#     }, error = function(e) {
#       cat("⚠ Warning: Could not install", pkg, "- this is optional\n")
#     })
#   } else {
#     cat("✓", pkg, "version", check$version, "already available\n")
#   }
# }

# # Final verification
# cat("\n=== Final Package Status ===\n")
# critical_packages <- c("shiny", "promises", "htmltools", "Biostrings")

# all_good <- TRUE
# for (pkg in critical_packages) {
#   check <- safe_package_check(pkg)
#   if (check$installed) {
#     cat("✓", pkg, "version:", check$version, "\n")
    
#     # Check minimum version requirements
#     if (pkg == "promises" && check$version < "1.5.0") {
#       cat("  ⚠ Warning: promises version", check$version, "may cause issues (recommend >= 1.5.0)\n")
#     }
#     if (pkg == "htmltools" && check$version < "0.5.4") {
#       cat("  ⚠ Warning: htmltools version", check$version, "may cause issues (recommend >= 0.5.4)\n") 
#     }
#   } else {
#     cat("✗", pkg, ": MISSING - MENTHU will not work\n")
#     all_good <- FALSE
#   }
# }

# cat("\n=== Installation Summary ===\n")
# if (all_good) {
#   cat("🎉 All critical packages installed successfully!\n")
#   cat("MENTHU should now be ready to run.\n")
#   cat("Start with: shiny::runApp()\n")
# } else {
#   cat("❌ Some critical packages are missing.\n")
#   cat("Try restarting R and running this script again.\n")
#   cat("If issues persist, you may need to restart your R session or check your library paths.\n")
# }

# cat("\n=== Troubleshooting Tips ===\n")
# cat("If you get 'package in use' errors:\n")
# cat("1. Restart R completely\n")
# cat("2. Run this script again\n")
# cat("3. Or run: .libPaths() to check library locations\n")

# install.packages(c('shiny', 'shinyjs', 'Rcpp', 'plyr', 'stringr', 'stringi', 'rentrez', 'rlist', 'DT', 
# 'devtools', 'rhandsontable', 'httr', 'jsonlite', 'xml2', 'curl'), 
# repos='https://cloud.r-project.org/')
conda create -n menthu_env r-base=4.3 -c conda-forge -y
# install.packages('promises', type='source', repos='https://cloud.r-project.org/')
# install.packages('shiny', repos='https://cloud.r-project.org/')
# install.packages(c('shinyjs', 'Rcpp', 'plyr', 'stringr', 'stringi', 'rentrez', 'rlist', 'DT', 
# 'rhandsontable', 'httr', 'jsonlite', 'xml2', 'curl'), repos='https://cloud.r-project.org/')
# install.packages('BiocManager')
# BiocManager::install('Biostrings')

# 1. Install base dependencies first (these are dependencies for other packages)
install.packages(c('Rcpp', 'stringi', 'jsonlite', 'curl', 'httr'), repos='https://cloud.r-project.org/')

# 2. Install string manipulation packages (stringr depends on stringi)
install.packages('stringr', repos='https://cloud.r-project.org/')

# 3. Install data manipulation packages
install.packages(c('plyr', 'xml2'), repos='https://cloud.r-project.org/')

# 4. Install web/API packages (rentrez may depend on httr/jsonlite)
install.packages('rentrez', repos='https://cloud.r-project.org/')

# 5. Install Shiny-related packages (these depend on many of the above)
# install.packages(c('shinyjs', 'DT', 'rhandsontable'), repos='https://cloud.r-project.org/')

# 6. Install utility packages
install.packages('rlist', repos='https://cloud.r-project.org/')

#7.
install.packages('promises', type='source', repos='https://cloud.r-project.org/')

#8.
install.packages(c('shiny', 'shinyjs', 'DT', 'rhandsontable'), repos='https://cloud.r-project.org/')

#9.
install.packages('BiocManager')
BiocManager::install('Biostrings')