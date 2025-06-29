<template>
  <div class="etl-dashboard">
    <h1>{{ $t('etl_title') || 'Pipeline ETL - Extract, Transform, Load' }}</h1>
    
    <!-- Statut général -->
    <div class="status-overview">
      <div class="status-card">
        <h3>Statut du Système</h3>
        <div v-if="systemStatus" class="status-grid">
          <div class="status-item">
            <span class="label">Base de données:</span>
            <span :class="systemStatus.database_exists ? 'success' : 'error'">
              {{ systemStatus.database_exists ? 'Connectée' : 'Non trouvée' }}
            </span>
          </div>
          <div class="status-item">
            <span class="label">Fichiers sources:</span>
            <span class="value">{{ systemStatus.source_files_count }}</span>
          </div>
          <div class="status-item">
            <span class="label">Fichiers traités:</span>
            <span class="value">{{ systemStatus.processed_files_count }}</span>
          </div>
          <div class="status-item">
            <span class="label">Indicateurs en BD:</span>
            <span class="value">{{ systemStatus.health_indicators_count }}</span>
          </div>
          <div class="status-item" v-if="systemStatus.last_etl_run">
            <span class="label">Dernière exécution:</span>
            <span class="value">{{ formatDate(systemStatus.last_etl_run) }}</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Contrôles ETL -->
    <div class="etl-controls">
      <div class="control-card">
        <h3>Contrôles ETL</h3>
        <button 
          @click="runETL" 
          :disabled="isRunningETL"
          class="btn-primary"
        >
          {{ isRunningETL ? 'ETL en cours...' : 'Lancer le processus ETL' }}
        </button>
        
        <button @click="refreshLogs" class="btn-secondary">
          Actualiser les logs
        </button>
        
        <button @click="refreshData" class="btn-secondary">
          Actualiser les données
        </button>
      </div>
    </div>

    <!-- Section des fichiers sources -->
    <div class="data-section">
      <h2>📁 Données Sources</h2>
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
            <p>Colonnes: {{ file.columns?.length || 0 }}</p>
            <p>Aperçu: {{ file.rows_sample || 0 }} lignes</p>
          </div>
          <div v-if="file.error" class="file-error">
            ❌ {{ file.error }}
          </div>
        </div>
      </div>
    </div>

    <!-- Section des données transformées -->
    <div class="data-section">
      <h2>🔄 Données Transformées</h2>
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
            <p>Colonnes: {{ file.columns?.length || 0 }}</p>
            <p>Aperçu: {{ file.rows_sample || 0 }} lignes</p>
          </div>
          <div v-if="file.error" class="file-error">
            ❌ {{ file.error }}
          </div>
        </div>
      </div>
    </div>

    <!-- Logs ETL -->
    <div class="logs-section">
      <h2>📋 Logs d'exécution</h2>
      <div class="logs-container">
        <div v-if="etlLogs.length === 0" class="no-logs">
          Aucun log disponible
        </div>
        <div v-else class="logs-content">
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
          <button @click="closeModal" class="btn-close">×</button>
        </div>
        
        <div v-if="previewData" class="modal-body">
          <div class="preview-info">
            <p><strong>Lignes:</strong> {{ previewData.total_rows }}</p>
            <p><strong>Colonnes:</strong> {{ previewData.columns.length }}</p>
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
          Chargement de l'aperçu...
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
import { fetchFromAPI } from '../../services/api.js'

// État réactif
const systemStatus = ref(null)
const sourceFiles = ref([])
const processedFiles = ref([])
const etlLogs = ref([])
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
    showStatus('Erreur lors du chargement des fichiers', 'error')
  }
}

const loadLogs = async () => {
  try {
    const response = await fetchFromAPI('/etl/logs/')
    etlLogs.value = response.logs || []
  } catch (error) {
    console.error('Erreur lors du chargement des logs:', error)
  }
}

// Fonctions d'action
const runETL = async () => {
  isRunningETL.value = true
  showStatus('Lancement du processus ETL...', 'info')
  
  try {
    const response = await fetchFromAPI('/etl/run/', {
      method: 'POST'
    })
    
    if (response.success) {
      showStatus('ETL exécuté avec succès!', 'success')
      await refreshData()
    } else {
      showStatus(`Erreur ETL: ${response.error || response.stderr}`, 'error')
    }
    
    // Actualiser les logs
    await loadLogs()
    
  } catch (error) {
    console.error('Erreur lors de l\'exécution ETL:', error)
    showStatus('Erreur lors de l\'exécution ETL', 'error')
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
    showStatus('Erreur lors du chargement de l\'aperçu', 'error')
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
}
</style>
