<template>
  <div class="etl-dashboard">
    <h1>{{ $t('etl_title') || 'Pipeline ETL - Extract, Transform, Load' }}</h1>
    
    <!-- Statut général -->
    <div class="status-overview">
      <div class="status-card">
        <h3>{{ $t('etl_system_status') }}</h3>
        <div v-if="systemStatus" class="status-grid">
          <div class="status-item">
            <span class="label">{{ $t('etl_database') }}:</span>
            <span :class="systemStatus.database_exists ? 'success' : 'error'">
              {{ systemStatus.database_exists ? $t('etl_connected') : $t('etl_not_found') }}
            </span>
          </div>
          <div class="status-item">
            <span class="label">{{ $t('etl_source_files') }}:</span>
            <span class="value">{{ systemStatus.source_files_count }}</span>
          </div>
          <div class="status-item">
            <span class="label">{{ $t('etl_processed_files') }}:</span>
            <span class="value">{{ systemStatus.processed_files_count }}</span>
          </div>
          <div class="status-item">
            <span class="label">{{ $t('etl_indicators_db') }}:</span>
            <span class="value">{{ systemStatus.health_indicators_count }}</span>
          </div>
          <div class="status-item" v-if="systemStatus.last_etl_run">
            <span class="label">{{ $t('etl_last_execution') }}:</span>
            <span class="value">{{ formatDate(systemStatus.last_etl_run) }}</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Contrôles ETL -->
    <div class="etl-controls">
      <div class="control-card">
        <h3>{{ $t('etl_controls') }}</h3>
        
        <!-- Message d'aide pour les encodages -->
        <div class="encoding-help">
          <h4> {{ $t('etl_encoding_help') || 'Help for encoding issues' }}</h4>
          <p>{{ $t('etl_encoding_text') || 'If you encounter UTF-8 errors, your CSV files may contain special characters (é, è, à...). The system automatically tries multiple encodings.' }}</p>
        </div>
        
        <div class="control-row">
          <button 
            @click="runETL" 
            :disabled="isRunningETL"
            class="btn-primary"
          >
            {{ isRunningETL ? $t('etl_running') : $t('etl_run_process') }}
          </button>
          
          <button @click="refreshLogs" class="btn-secondary">
            {{ $t('etl_refresh_logs') }}
          </button>
          
          <button @click="refreshData" class="btn-secondary">
            {{ $t('etl_refresh_data') }}
          </button>
          
          <button @click="testFileEncodings" class="btn-secondary">
            {{ $t('etl_test_encodings') || 'Test encodings' }}
          </button>
        </div>
      </div>
    </div>

    <!-- Section des fichiers sources -->
    <div class="data-section">
      <h2>{{ $t('etl_source_data') }}</h2>
      
      <!-- Message d'aide si pas de fichiers -->
      <div v-if="sourceFiles.length === 0" class="no-files-message">
        <h3> {{ $t('etl_no_source_files') }}</h3>
        <p>{{ $t('etl_check_directory') }} <code>backend/NewETL/SourceData/</code></p>
        <button @click="loadSourceFiles" class="btn-secondary"> {{ $t('etl_reload') }}</button>
      </div>
      
      <div v-else class="files-grid">
        <div 
          v-for="file in sourceFiles" 
          :key="file.name"
          class="file-card"
          @click="showFilePreview('source', file.name)"
        >
          <div class="file-header">
            <h4>{{ file.name }}</h4>
            <span class="file-size">{{ formatSize(file.size) }}</span>
          </div>
          <div class="file-info">
            <p>{{ $t('etl_columns') }}: {{ file.columns?.length || 0 }}</p>
            <p>{{ $t('etl_preview') }}: {{ file.rows_sample || 0 }} {{ $t('etl_lines') }}</p>
            <p v-if="file.encoding"> {{ $t('etl_encoding') }}: {{ file.encoding }}</p>
          </div>
          <div v-if="file.error" class="file-error">
             {{ file.error }}
          </div>
        </div>
      </div>
    </div>

    <!-- Section des données transformées -->
    <div class="data-section">
      <h2>{{ $t('etl_transformed_data') }}</h2>
      <div class="files-grid">
        <div 
          v-for="file in processedFiles" 
          :key="file.name"
          class="file-card"
          @click="showFilePreview('processed', file.name)"
        >
          <div class="file-header">
            <h4>{{ file.name }}</h4>
            <span class="file-size">{{ formatSize(file.size) }}</span>
          </div>
          <div class="file-info">
            <p>{{ $t('etl_columns') }}: {{ file.columns?.length || 0 }}</p>
            <p>{{ $t('etl_preview') }}: {{ file.rows_sample || 0 }} {{ $t('etl_lines') }}</p>
            <p v-if="file.encoding"> {{ $t('etl_encoding') }}: {{ file.encoding }}</p>
            <p v-if="file.separator"> {{ $t('etl_separator') }}: {{ file.separator }}</p>
          </div>
          <div v-if="file.error" class="file-error">
             {{ file.error }}
          </div>
        </div>
      </div>
    </div>

    <!-- Logs ETL -->
    <div class="logs-section">
      <h2>{{ $t('etl_execution_logs') }}</h2>
      <div class="logs-container">
        <div v-if="etlLogs.length === 0" class="no-logs">
          {{ $t('etl_no_logs') || 'Aucun log disponible. Lancez l\'ETL pour voir les logs d\'exécution.' }}
        </div>
        <div v-else class="logs-content">
          <div class="logs-header">
            <small> {{ etlLogs.length }} {{ $t('etl_lines_displayed') }} |  {{ $t('etl_last_update') }}: {{ logsLastUpdate }}</small>
          </div>
          <div 
            v-for="(log, index) in etlLogs" 
            :key="index"
            class="log-line"
            :class="getLogClass(log)"
          >
            {{ log }}
          </div>
        </div>
      </div>
    </div>

    <!-- Modal de prévisualisation -->
    <div v-if="showModal" class="modal-overlay" @click="closeModal">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3>{{ previewData?.file_name }}</h3>
          <button @click="closeModal" class="btn-close">{{ $t('etl_close') }}</button>
        </div>
        
        <div v-if="previewData" class="modal-body">
          <div class="preview-info">
            <p><strong>{{ $t('etl_lines') }}:</strong> {{ previewData.total_rows }}</p>
            <p><strong>{{ $t('etl_columns') }}:</strong> {{ previewData.columns.length }}</p>
            <p v-if="previewData.encoding_used"><strong> {{ $t('etl_encoding') }}:</strong> {{ previewData.encoding_used }}</p>
            <p v-if="previewData.separator_used"><strong> {{ $t('etl_separator') }}:</strong> {{ previewData.separator_used }}</p>
          </div>
          
          <div class="table-container">
            <table class="preview-table">
              <thead>
                <tr>
                  <th v-for="col in previewData.columns" :key="col">{{ col }}</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="(row, index) in previewData.data.slice(0, 10)" :key="index">
                  <td v-for="col in previewData.columns" :key="col">
                    {{ row[col] }}
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
        
        <div v-if="previewLoading" class="loading">
          {{ $t('etl_preview_loading') }}
        </div>
      </div>
    </div>

    <!-- Messages de statut -->
    <div v-if="statusMessage" :class="`status-message ${statusMessage.type}`">
      {{ statusMessage.text }}
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useI18n } from 'vue-i18n'
import { fetchFromAPI } from '../../services/api.js'

const { t } = useI18n()

// État réactif
const systemStatus = ref(null)
const sourceFiles = ref([])
const processedFiles = ref([])
const etlLogs = ref([])
const logsLastUpdate = ref(null)
const isRunningETL = ref(false)
const showModal = ref(false)
const previewData = ref(null)
const previewLoading = ref(false)
const statusMessage = ref(null)

// Chargement initial
onMounted(async () => {
  await loadSystemStatus()
  await loadSourceFiles()
  await loadLogs()
})

// Fonctions de chargement des données
const loadSystemStatus = async () => {
  try {
    systemStatus.value = await fetchFromAPI('/etl/status/')
  } catch (error) {
    console.error('Erreur lors du chargement du statut:', error)
  }
}

const loadSourceFiles = async () => {
  try {
    console.log(' Chargement des fichiers ETL...')
    const response = await fetchFromAPI('/etl/source-files/')
    console.log(' Réponse API reçue:', response)
    
    sourceFiles.value = response.source_files || []
    processedFiles.value = response.processed_files || []
    
    // Afficher des informations de debug
    console.log(` ${t('etl_source_files_loaded') || 'Fichiers sources chargés'}:`, sourceFiles.value.length)
    console.log(` ${t('etl_processed_files_loaded') || 'Fichiers traités chargés'}:`, processedFiles.value.length)
    
    // Vérifier s'il y a des erreurs dans la réponse
    if (response.error) {
      console.warn(' Erreur dans la réponse API:', response.error)
      showStatus(` ${response.error}`, 'error')
    }
    
    // Vérifier s'il y a des erreurs dans les fichiers
    const sourceErrors = sourceFiles.value.filter(f => f.error).length
    const processedErrors = processedFiles.value.filter(f => f.error).length
    
    if (sourceErrors > 0) {
      console.warn(` ${sourceErrors} ${t('etl_source_files_with_errors') || 'fichier(s) source(s) avec des erreurs'}`)
    }
    if (processedErrors > 0) {
      console.warn(` ${processedErrors} ${t('etl_processed_files_with_errors') || 'fichier(s) traité(s) avec des erreurs'}`)
    }
    
  } catch (error) {
    console.error(`${t('etl_error_loading_files') || 'Erreur lors du chargement des fichiers'}:`, error)
    
    // Message d'erreur plus spécifique
    let errorMessage = t('etl_file_error')
    if (error.response && error.response.status === 500) {
      errorMessage = t('etl_server_error')
    } else if (error.message) {
      errorMessage = `${t('error')}: ${error.message}`
    }
    
    showStatus(errorMessage, 'error')
    
    // Initialiser avec des tableaux vides pour éviter les erreurs d'affichage
    sourceFiles.value = []
    processedFiles.value = []
  }
}

const loadLogs = async () => {
  try {
    const response = await fetchFromAPI('/etl/logs/')
    etlLogs.value = response.logs || []
    logsLastUpdate.value = new Date().toLocaleTimeString('fr-FR')
    
    // Afficher des informations de debug si disponibles
    if (response.encoding_used) {
      console.log(` ${t('etl_logs_loaded_encoding')}: ${response.encoding_used}`)
    }
    if (response.total_lines) {
      console.log(` ${t('etl_total_log_lines') || 'Total de lignes dans le fichier de log'}: ${response.total_lines}`)
    }
  } catch (error) {
    console.error(`${t('etl_error_loading_logs') || 'Erreur lors du chargement des logs'}:`, error)
    etlLogs.value = [` ${t('etl_error_loading_logs') || 'Erreur lors du chargement des logs'}: ${error.message}`]
    logsLastUpdate.value = new Date().toLocaleTimeString('fr-FR')
  }
}

// Fonctions d'action
const runETL = async () => {
  isRunningETL.value = true
  showStatus(t('etl_launching'), 'info')
  
  try {
    const response = await fetchFromAPI('/etl/run/', {
      method: 'POST'
    })
    
    console.log(` ${t('etl_complete_response') || 'Réponse ETL complète'}:`, response)
    
    if (response.success) {
      showStatus(` ${t('etl_success_message')} ${t('etl_check_logs_details') || 'Consultez les logs pour plus de détails.'}`, 'success')
      
      // Afficher des statistiques si disponibles
      if (response.results && response.results.processing_stats) {
        const stats = response.results.processing_stats
        console.log(` ${t('etl_stats') || 'Statistiques ETL'}: ${stats.success}/${stats.processed} ${t('etl_lines_processed') || 'lignes traitées'}`)
      }
      
      await refreshData()
    } else {
      // Messages d'erreur améliorés
      let errorMessage = response.error || t('etl_unknown_error') || 'Erreur inconnue'
      
      // Identifier les erreurs d'encodage spécifiquement
      if (errorMessage.includes('utf-8') && (errorMessage.includes('decode') || errorMessage.includes('codec'))) {
        showStatus(` ${t('etl_encoding_persistent_error')}`, 'error')
      } else if (errorMessage.includes('UnicodeDecodeError')) {
        showStatus(` ${t('etl_encoding_problem')}`, 'error')
      } else if (errorMessage.includes('FileNotFoundError') || errorMessage.includes('non trouvé')) {
        showStatus(` ${t('etl_missing_files_error')}`, 'error')
      } else {
        showStatus(` ${t('etl_error_message')}: ${errorMessage}`, 'error')
      }
    }
    
    // Toujours actualiser les logs après une tentative d'ETL
    await loadLogs()
    
  } catch (error) {
    console.error(` ${t('etl_error_execution') || 'Erreur lors de l\'exécution ETL'}:`, error)
    showStatus(` ${t('etl_communication_error')}: ${error.message}`, 'error')
  } finally {
    isRunningETL.value = false
  }
}

const showFilePreview = async (fileType, fileName) => {
  console.log(` Demande de preview: ${fileType}/${fileName}`)
  previewLoading.value = true
  showModal.value = true
  
  try {
    const url = `/etl/file-preview/${fileType}/${fileName}`
    console.log(` Appel API: ${url}`)
    
    previewData.value = await fetchFromAPI(url)
    console.log(' Preview chargé avec succès:', previewData.value?.file_name)
  } catch (error) {
    console.error(` Erreur preview:`, error)
    console.error(` Type d'erreur:`, error.constructor.name)
    console.error(` Status:`, error.response?.status)
    console.error(` Message:`, error.message)
    
    let errorMessage = t('etl_preview_error')
    if (error.response?.status === 500) {
      errorMessage = ` Erreur serveur lors du preview de ${fileName}. Le backend a rencontré un problème.`
    } else if (error.response?.status === 404) {
      errorMessage = ` Fichier ${fileName} non trouvé.`
    } else {
      errorMessage = ` Erreur preview: ${error.message}`
    }
    
    showStatus(errorMessage, 'error')
    closeModal()
  } finally {
    previewLoading.value = false
  }
}

const refreshData = async () => {
  await loadSystemStatus()
  await loadSourceFiles()
}

const refreshLogs = async () => {
  await loadLogs()
}

const testFileEncodings = async () => {
  showStatus(` ${t('etl_testing_encodings') || 'Test des encodages des fichiers...'}`, 'info')
  
  try {
    const response = await fetchFromAPI('/etl/test-encodings/')
    
    if (response.results) {
      let message = ` ${t('etl_test_encoding_results')}:\n`
      response.results.forEach(result => {
        message += `${result.file}: ${result.encoding || t('error') || 'ERREUR'}\n`
      })
      
      // Afficher dans la console pour plus de détails
      console.log(` ${t('etl_encoding_details') || 'Détails des encodages'}:`, response.results)
      showStatus(message, 'success')
    }
  } catch (error) {
    console.error(`${t('etl_encoding_test_error')}`, error)
    showStatus(` ${t('etl_cannot_test_encodings') || 'Impossible de tester les encodages'}`, 'error')
  }
}

const closeModal = () => {
  showModal.value = false
  previewData.value = null
}

// Fonctions utilitaires
const formatSize = (bytes) => {
  if (!bytes) return '0 B'
  const k = 1024
  const sizes = ['B', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(k))
  return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + ' ' + sizes[i]
}

const formatDate = (dateStr) => {
  if (!dateStr) return 'N/A'
  return new Date(dateStr).toLocaleString('fr-FR')
}

const getLogClass = (log) => {
  if (log.includes('ERROR')) return 'log-error'
  if (log.includes('WARNING')) return 'log-warning'
  if (log.includes('INFO')) return 'log-info'
  return 'log-default'
}

const showStatus = (text, type) => {
  statusMessage.value = { text, type }
  setTimeout(() => {
    statusMessage.value = null
  }, 5000)
}
</script>

<style scoped>
.etl-dashboard {
  padding: 2em;
  max-width: 1400px;
  margin: 0 auto;
}

.status-overview {
  margin-bottom: 2em;
}

.status-card, .control-card {
  background: white;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 1.5em;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.status-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1em;
  margin-top: 1em;
}

.status-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.5em;
  border-bottom: 1px solid #f0f0f0;
}

.label {
  font-weight: 500;
  color: #666;
}

.value {
  font-weight: bold;
  color: #333;
}

.success {
  color: #28a745;
  font-weight: bold;
}

.error {
  color: #dc3545;
  font-weight: bold;
}

.etl-controls {
  margin-bottom: 2em;
}

.etl-controls .control-card {
  display: flex;
  flex-direction: column;
  gap: 1em;
}

.encoding-help {
  background-color: #e7f3ff;
  border: 1px solid #bee5eb;
  border-radius: 4px;
  padding: 1em;
  margin-bottom: 1em;
}

.encoding-help h4 {
  margin: 0 0 0.5em 0;
  color: #004085;
  font-size: 0.9em;
}

.encoding-help p {
  margin: 0;
  color: #004085;
  font-size: 0.8em;
  line-height: 1.4;
}

.etl-controls .control-row {
  display: flex;
  gap: 1em;
  align-items: center;
}

.btn-primary, .btn-secondary {
  padding: 0.75em 1.5em;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-weight: 500;
  transition: background-color 0.2s;
}

.btn-primary {
  background-color: #007bff;
  color: white;
}

.btn-primary:hover:not(:disabled) {
  background-color: #0056b3;
}

.btn-primary:disabled {
  background-color: #6c757d;
  cursor: not-allowed;
}

.btn-secondary {
  background-color: #6c757d;
  color: white;
}

.btn-secondary:hover {
  background-color: #545b62;
}

.data-section {
  margin-bottom: 2em;
}

.data-section h2 {
  color: #333;
  border-bottom: 2px solid #007bff;
  padding-bottom: 0.5em;
  margin-bottom: 1em;
}

.files-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 1em;
}

.file-card {
  background: white;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  padding: 1em;
  cursor: pointer;
  transition: box-shadow 0.2s, border-color 0.2s;
}

.file-card:hover {
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  border-color: #007bff;
}

.file-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 0.5em;
}

.file-header h4 {
  margin: 0;
  color: #333;
  font-size: 0.9em;
}

.file-size {
  color: #666;
  font-size: 0.8em;
}

.file-info p {
  margin: 0.25em 0;
  color: #666;
  font-size: 0.8em;
}

.file-error {
  color: #dc3545;
  font-size: 0.8em;
  margin-top: 0.5em;
}

.no-files-message {
  text-align: center;
  padding: 2em;
  background: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  margin-bottom: 1em;
}

.no-files-message h3 {
  color: #666;
  margin-bottom: 1em;
}

.no-files-message p {
  color: #666;
  margin-bottom: 1.5em;
}

.no-files-message code {
  background: #e9ecef;
  padding: 0.2em 0.4em;
  border-radius: 3px;
  font-family: monospace;
}

.logs-section {
  margin-bottom: 2em;
}

.logs-container {
  background: #f8f9fa;
  border: 1px solid #e9ecef;
  border-radius: 8px;
  height: 300px;
  overflow-y: auto;
}

.no-logs {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  color: #666;
  font-style: italic;
}

.logs-content {
  padding: 1em;
}

.logs-header {
  background-color: #f8f9fa;
  padding: 0.5em;
  border-bottom: 1px solid #e9ecef;
  margin: -1em -1em 1em -1em;
  font-size: 0.8em;
  color: #666;
}

.log-line {
  font-family: 'Courier New', monospace;
  font-size: 0.8em;
  margin-bottom: 0.25em;
  padding: 0.25em;
  border-radius: 3px;
}

.log-error {
  background-color: #f8d7da;
  color: #721c24;
}

.log-warning {
  background-color: #fff3cd;
  color: #856404;
}

.log-info {
  background-color: #d1ecf1;
  color: #0c5460;
}

.log-default {
  color: #333;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0,0,0,0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 8px;
  max-width: 90vw;
  max-height: 90vh;
  overflow: hidden;
  display: flex;
  flex-direction: column;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1em;
  border-bottom: 1px solid #e9ecef;
}

.btn-close {
  background: none;
  border: none;
  font-size: 1.5em;
  cursor: pointer;
  color: #666;
}

.modal-body {
  padding: 1em;
  overflow: auto;
  flex: 1;
}

.preview-info {
  margin-bottom: 1em;
  display: flex;
  gap: 2em;
}

.table-container {
  overflow: auto;
}

.preview-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.8em;
}

.preview-table th,
.preview-table td {
  border: 1px solid #e9ecef;
  padding: 0.5em;
  text-align: left;
}

.preview-table th {
  background-color: #f8f9fa;
  font-weight: bold;
  position: sticky;
  top: 0;
}

.loading {
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2em;
  color: #666;
}

.status-message {
  position: fixed;
  top: 20px;
  right: 20px;
  padding: 1em;
  border-radius: 4px;
  color: white;
  font-weight: 500;
  z-index: 1001;
}

.status-message.success {
  background-color: #28a745;
}

.status-message.error {
  background-color: #dc3545;
}

.status-message.info {
  background-color: #17a2b8;
}

@media (max-width: 768px) {
  .etl-dashboard {
    padding: 1em;
  }
  
  .files-grid {
    grid-template-columns: 1fr;
  }
  
  .status-grid {
    grid-template-columns: 1fr;
  }
  
  .etl-controls .control-card {
    flex-direction: column;
    align-items: stretch;
  }
  
  .etl-controls .control-row {
    flex-direction: column;
    align-items: stretch;
  }
}
</style>
