{{/*
Expand the name of the chart.
*/}}
{{- define "paperless.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "paperless.fullname" -}}
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
{{- define "paperless.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "paperless.labels" -}}
helm.sh/chart: {{ include "paperless.chart" . }}
{{ include "paperless.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "paperless.selectorLabels" -}}
app.kubernetes.io/name: {{ include "paperless.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "paperless.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "paperless.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the secret key secret
*/}}
{{- define "paperless.secretKeyName" -}}
{{- $name := printf "%s-%s" (include "paperless.fullname" .) "secret-key" }}
{{- default $name | trunc 63 }}
{{- end }}

# {{/*
# Create the name of the superuser password secret
*/}}
{{- define "paperless.superUserName" -}}
{{- $name := printf "%s-%s" (include "paperless.fullname" .) "super-user" }}
{{- default $name | trunc 63 }}
{{- end }}

# {{/*
# Create the name of the database password secret
*/}}
{{- define "paperless.database.password" -}}
{{- $name := printf "%s-%s" (include "paperless.fullname" .) "database-password" }}
{{- default $name | trunc 63 }}
{{- end }}

# {{/*
# Create the name of the export pvc
*/}}
{{- define "paperless.export.pvc" -}}
{{- $name := printf "%s-%s" (include "paperless.fullname" .) "export-pvc" }}
{{- default $name | trunc 63 }}
{{- end }}

# {{/*
# Create the name of the data pvs
*/}}
{{- define "paperless.data.pvc" -}}
{{- $name := printf "%s-%s" (include "paperless.fullname" .) "data-pvc" }}
{{- default $name | trunc 63 }}
{{- end }}


# {{/*
# Create the name of the media pvs
*/}}
{{- define "paperless.media.pvc" -}}
{{- $name := printf "%s-%s" (include "paperless.fullname" .) "media-pvc" }}
{{- default $name | trunc 63 }}
{{- end }}


# {{/*
# Create the name of the consume pvs
*/}}
{{- define "paperless.consume.pvc" -}}
{{- $name := printf "%s-%s" (include "paperless.fullname" .) "consume-pvc" }}
{{- default $name | trunc 63 }}
{{- end }}
