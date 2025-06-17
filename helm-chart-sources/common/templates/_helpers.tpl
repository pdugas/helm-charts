# -----------------------------------------------------------------------------
# `common.name` returns the name from the Chart's `Chart.yaml` file.
#
# Users can optionally override this by setting `nameOverride`.
# -----------------------------------------------------------------------------
{{- define "common.name" -}}
  {{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

# -----------------------------------------------------------------------------
# `common.fullname` returns a default fully qualified app name.
#
# Users can optionally override this by setting `fullnameOverride`.
#
# We truncate at 63 chars because some Kubernetes name fields are limited to
# this (by the DNS naming spec). 
#
# If release name contains chart name it will be used as the full name.
# -----------------------------------------------------------------------------
{{- define "common.fullname" -}}
  {{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
  {{- else }}
    {{- $name := default .Chart.Name .Values.nameOverride }}
    {{- if contains $name .Release.Name }}
      {{- .Release.Name | trunc 63 | trimSuffix "-" }}
    {{- else }}
      {{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
    {{- end }}
  {{- end }}
{{- end }}

# -----------------------------------------------------------------------------
# `common.chart` is the Chart's name and version concatenated with a hyphen.
#
# This is commonly used as a label.
#
# Example: `mychart-1.2.3`
# -----------------------------------------------------------------------------
{{- define "common.chart" -}}
  {{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

# -----------------------------------------------------------------------------
# `common.labels` returns a set of labels that are commonly used for objects
# created by our charts.
#
# This includes the Chart's name and version, the App's version, and the
# release service.
# -----------------------------------------------------------------------------
{{- define "common.labels" -}}
helm.sh/chart: {{ include "common.chart" . }}
{{ include "common.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

# -----------------------------------------------------------------------------
# `common.selectorLabels` returns a set of labels that are commonly used for
# objects created by our charts that need to be picked using a selector.
#
# This includes the App's name and instance.
# -----------------------------------------------------------------------------
{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

# -----------------------------------------------------------------------------
# `common.serviceAccountName` returns the name of the ServiceAccount to use.
#
# If the ServiceAccount is not created, the default is "default".
#
# If the ServiceAccount is created, the name is the value of the
# `serviceAccount.name` value.
#
# If the ServiceAccount is created and the `serviceAccount.name` value is not
# set, the name is the value of the `common.fullname` value.
# -----------------------------------------------------------------------------
{{- define "common.serviceAccountName" -}}
  {{- if (.Values.serviceAccount).create }}
    {{- default (include "common.fullname" .) .Values.serviceAccount.name }}
  {{- else }}
    {{- default "default" (.Values.serviceAccount).name }}
  {{- end }}
{{- end }}
