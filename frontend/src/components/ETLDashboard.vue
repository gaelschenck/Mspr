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
          <h4>💡 {{ $t('etl_encoding_help') || 'Aide pour les problèmes d\'encodage' }}</h4>
          <p>{{ $t('etl_encoding_text') || 'Si vous rencontrez des erreurs UTF-8, vos fichiers CSV peuvent contenir des caractères spéciaux (é, è, à...). Le système essaie automatiquement plusieurs encodages.' }}</p>
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
            {{ $t('etl_test_encodings') || 'Tester encodages' }}
          </button>
        </div>
      </div>
    </div>

    <!-- Section des fichiers sources -->
    <div class="data-section">
      <h2>{{ $t('etl_source_data') }}</h2>
      <div class="files-grid">
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
          </div>
          <div v-if="file.error" class="file-error">
            ❌ {{ file.error }}
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
          </div>
          <div v-if="file.error" class="file-error">
            ❌ {{ file.error }}
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
            <small>📊 {{ etlLogs.length }} lignes affichées | 🔄 Dernière actualisation: {{ logsLastUpdate }}</small>
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
    const response = await fetchFromAPI('/etl/source-files/')
    sourceFiles.value = response.source_files || []
    processedFiles.value = response.processed_files || []
  } catch (error) {
    console.error('Erreur lors du chargement des fichiers:', error)
    showStatus(t('etl_file_error'), 'error')
  }
}

const loadLogs = async () => {
  try {
    const response = await fetchFromAPI('/etl/logs/')
    etlLogs.value = response.logs || []
    logsLastUpdate.value = new Date().toLocaleTimeString('fr-FR')
    
    // Afficher des informations de debug si disponibles
    if (response.encoding_used) {
      console.log(`📝 Logs chargés avec encodage: ${response.encoding_used}`)
    }
    if (response.total_lines) {
      console.log(`📊 Total de lignes dans le fichier de log: ${response.total_lines}`)
    }
  } catch (error) {
    console.error('Erreur lors du chargement des logs:', error)
    etlLogs.value = [`❌ Erreur lors du chargement des logs: ${error.message}`]
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
    
    console.log('📋 Réponse ETL complète:', response)
    
    if (response.success) {
      showStatus('✅ ETL exécuté avec succès! Consultez les logs pour plus de détails.', 'success')
      
      // Afficher des statistiques si disponibles
      if (response.results && response.results.processing_stats) {
        const stats = response.results.processing_stats
        console.log(`📊 Statistiques ETL: ${stats.success}/${stats.processed} lignes traitées`)
      }
      
      await refreshData()
    } else {
      // Messages d'erreur améliorés
      let errorMessage = response.error || 'Erreur inconnue'
      
      // Identifier les erreurs d'encodage spécifiquement
      if (errorMessage.includes('utf-8') && (errorMessage.includes('decode') || errorMessage.includes('codec'))) {
        showStatus('❌ Erreur d\'encodage persistante! Vérifiez que vos fichiers CSV sont dans le bon répertoire SourceData et utilisez le bouton "Tester encodages" pour diagnostiquer.', 'error')
      } else if (errorMessage.includes('UnicodeDecodeError')) {
        showStatus('❌ Problème d\'encodage: Utilisez le bouton "Tester encodages" pour diagnostiquer vos fichiers CSV.', 'error')
      } else if (errorMessage.includes('FileNotFoundError') || errorMessage.includes('non trouvé')) {
        showStatus('❌ Fichiers sources manquants! Vérifiez que les fichiers CSV sont dans le dossier NewETL/SourceData/', 'error')
      } else {
        showStatus(`❌ Erreur ETL: ${errorMessage}`, 'error')
      }
    }
    
    // Toujours actualiser les logs après une tentative d'ETL
    await loadLogs()
    
  } catch (error) {
    console.error('❌ Erreur lors de l\'exécution ETL:', error)
    showStatus(`❌ Erreur de communication: ${error.message}`, 'error')
  } finally {
    isRunningETL.value = false
  }
}

const showFilePreview = async (fileType, fileName) => {
  previewLoading.value = true
  showModal.value = true
  
  try {
    previewData.value = await fetchFromAPI(`/etl/file-preview/${fileType}/${fileName}`)
  } catch (error) {
    console.error('Erreur lors du chargement de l\'aperçu:', error)
    showStatus(t('etl_preview_error'), 'error')
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
  showStatus('🔍 Test des encodages des fichiers...', 'info')
  
  try {
    const response = await fetchFromAPI('/etl/test-encodings/')
    
    if (response.results) {
      let message = '📊 Résultats du test d\'encodage:\n'
      response.results.forEach(result => {
        message += `${result.file}: ${result.encoding || 'ERREUR'}\n`
      })
      
      // Afficher dans la console pour plus de détails
      console.log('📋 Détails des encodages:', response.results)
      showStatus(message, 'success')
    }
  } catch (error) {
    console.error('Erreur lors du test d\'encodage:', error)
    showStatus('❌ Impossible de tester les encodages', 'error')
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
