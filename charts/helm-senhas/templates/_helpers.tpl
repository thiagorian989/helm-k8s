{{/*
Criar nossas tags
*/}}
{{- define "app.labels" -}}
app: {{ .labels.app }}
env: {{ .labels.env | quote }}
live: {{ .labels.live | quote }}
{{- end }}

{{/*
Tag - Limies de recursos
*/}}
{{- define "app.resources" -}}
requests:
  memory: {{ .resources.requests.memory }}
  cpu: {{ .resources.requests.cpu }}
limits:
  memory: {{ .resources.limits.memory }}
  cpu: {{ .resources.limits.cpu }}
{{- end}}

{{/*
Tag - Portas dos containers
*/}}
{{- define "app.ports" -}}
{{ range .ports }}
- containerPort: {{ .port }}
{{- end }}
{{- end }}

{{/*
Tag -  ConfigMap Database
*/}}
{{- define "database.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-db-config
data:
  app-confi.yaml: |
    {{- toYaml .config | nindent 4 }}
{{- end }}

{{/*
Tag - ConfigMap Observability
*/}}
{{- define "observability.configmap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .component }}-observability-config
data:
  app-config.json: |
    {{ toJson .config }}
{{- end }}
