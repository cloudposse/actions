#!/usr/bin/env bash

################################################################################
############# Clean all code base for additional testing @admiralawkbar #########
################################################################################

###########
# Globals #
###########
GITHUB_WORKSPACE="${GITHUB_WORKSPACE}" # GitHub Workspace
GITHUB_SHA="${GITHUB_SHA}"             # Sha used to create this branch
BUILD_DATE="${BUILD_DATE}"             # Date the container was built
BUILD_REVISION="${GITHUB_SHA}"         # GitHub Sha
BUILD_VERSION="${GITHUB_SHA}"          # Version of the container
ORG_REPO="nvuillam/mega-linter"        # Org/repo
ERROR=0                                # Error count

#########################
# Source Function Files #
#########################
# shellcheck source=/dev/null
source "${GITHUB_WORKSPACE}/.automation/log.sh" # Source the function script(s)

################################################################################
############################ FUNCTIONS BELOW ###################################
################################################################################
################################################################################
#### Function Header ###########################################################
Header() {
  info "--------------------------------------------------"
  info "----- GitHub Actions validate docker labels ------"
  info "--------------------------------------------------"
}
################################################################################
#### Function ValidateLabel ####################################################
ValidateLabel() {
  ##############
  # Grab input #
  ##############
  CONTAINER_KEY="$1"   # Example: org.opencontainers.image.created
  CONTAINER_VALUE="$2" # Example: 1985-04-12T23:20:50.52Z

  ########################
  # Get the docker label #
  ########################
  LABEL=$(docker inspect --format "{{ index .Config.Labels \"${CONTAINER_KEY}\" }}" "${ORG_REPO}:${GITHUB_SHA}")

  ###################
  # Check the value #
  ###################
  if [[ ${LABEL} != "${CONTAINER_VALUE}" ]]; then
    error "Assert failed [${CONTAINER_KEY} - '${LABEL}' != '${CONTAINER_VALUE}']"
    ERROR=1
  else
    info "Assert passed [${CONTAINER_KEY}]"
  fi
}
################################################################################
#### Function Footer ###########################################################
Footer() {
  #####################################
  # Check if any errors were reported #
  #####################################
  if [[ ${ERROR} -gt 0 ]]; then
    fatal "There were some failed assertions. See above"
  else
    info "-------------------------------------------------------"
    info "The step has completed"
    info "-------------------------------------------------------"
  fi
}
################################################################################
################################## MAIN ########################################
################################################################################

####################
# Validate created #
####################
ValidateLabel "org.opencontainers.image.created" "${BUILD_DATE}"

#####################
# Validate revision #
#####################
ValidateLabel "org.opencontainers.image.revision" "${BUILD_REVISION}"

####################
# Validate version #
####################
ValidateLabel "org.opencontainers.image.version" "${BUILD_VERSION}"

#################
# Report status #
#################
Footer
