{{/*
Authority Name
*/}}
{{- define "authority" -}}
{{- $path := include "ingress.path" . -}}
{{- with (index .Values.ingress.hosts 0) }}
{{- printf "https://%s%s"  .host $path -}}
{{- end -}}
{{- end -}}

{{- define "ingress.path" -}}
{{- with (index .Values.ingress.hosts 0) }}
{{- with (index .paths 0) }}
{{- printf "%s"  .path -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the chart.
*/}}
{{- define "authentication.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "authentication.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "authentication.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "authentication.labels" -}}
helm.sh/chart: {{ include "authentication.chart" . }}
{{ include "authentication.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "authentication.selectorLabels" -}}
app.kubernetes.io/name: {{ include "authentication.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "authentication.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "authentication.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
