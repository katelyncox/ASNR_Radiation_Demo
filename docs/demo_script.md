# ASNR Demo Script

## Demo Setup (5 minutes before presentation)

1. Open Posit Workbench
2. Load the ASNR_Radiation_Demo project
3. Ensure all data files are generated
4. Have both technical report and Shiny app ready to demonstrate

## Demo Flow (15-20 minutes total)

### Act 1: The Challenge (2 minutes)

**Narrator**: "Marie Dubois, Senior Data Analyst at ASNR, receives an urgent request. Citizens near Flamanville nuclear facility have reported concerns about potential radiation increases. ASNR needs to provide both rapid technical assessment and transparent public communication."

**Show**: Email or notification about public concern

**Key Points**:
- Government agencies face dual challenges: technical rigor + public transparency
- Traditional analysis would take weeks
- Public trust requires immediate, accessible information

### Act 2: Posit Workbench - The Secure Workspace (3-4 minutes)

**Demo Actions**:
1. Open RStudio in Posit Workbench
2. Show project structure and organization
3. Demonstrate Git integration (version history)
4. Show package management with validated libraries

**Narration Points**:
- "Marie works in a secure, enterprise environment"
- "All packages come from ASNR's validated repository"
- "Every analysis is version-controlled and auditable"
- "Collaboration happens seamlessly with colleagues"

**Show**:
```r
# Load validated packages from ASNR's package manager
library(tidyverse)
library(forecast)
library(leaflet)
source("R/radiation_analysis.R")
```

### Act 3: Data Analysis in Action (4-5 minutes)

**Demo Actions**:
1. Load and examine sensor data
2. Run anomaly detection
3. Create time series visualization
4. Show spatial mapping

**Code to Demonstrate**:
```r
# Load data
data_list <- load_radiation_data()
sensors_data <- data_list$sensors

# Detect anomalies
anomalies <- detect_anomalies(sensors_data)

# Create visualizations
create_timeseries_plot(sensors_data)
create_sensor_map(sensors_data)
```

**Narration Points**:
- "Marie loads 30 days of data from 15 sensors - over 10,000 measurements"
- "Statistical process control automatically flags anomalies"
- "The system reveals the 'anomaly' correlates with weather patterns"
- "Interactive maps provide geographic context"

**Key Insight**: "The apparent radiation spike coincides with atmospheric conditions that concentrated natural radon - not a facility leak."

### Act 4: Dual-Purpose Outputs (3-4 minutes)

#### Technical Report
**Demo Actions**:
1. Open `technical_report.Rmd`
2. Show code integration with narrative
3. Render to HTML/PDF

**Narration**:
- "For ASNR experts: comprehensive 15-page technical analysis"
- "All R code included for complete reproducibility"
- "Statistical methodologies and regulatory compliance detailed"

#### Public Dashboard
**Demo Actions**:
1. Launch Shiny app
2. Navigate through French interface
3. Show real-time monitoring features
4. Demonstrate interactive map
5. Show mobile-responsive design

**Narration**:
- "For the public: same analysis, accessible presentation"
- "Real-time updates in French"
- "Interactive features without requiring technical expertise"
- "Mobile-friendly for citizen access"

### Act 5: Deployment Magic - Posit Connect (2-3 minutes)

**Demo Actions**:
1. Show publishing from Workbench to Connect
2. Demonstrate scheduled report automation
3. Show access controls and permissions
4. Display usage analytics

**Narration Points**:
- "One-click deployment from development to production"
- "Technical report automatically regenerates daily at 6 AM"
- "Public dashboard available 24/7 with secure hosting"
- "Different access levels: public dashboard vs. internal reports"

**Show**: Connect interface with deployed applications

### Act 6: Impact and Value (2 minutes)

**Quantifiable Results**:
- Time: 3 weeks → 4 hours
- Public trust: 80% reduction in citizen complaints
- Reproducibility: 100% of analyses fully documented
- Scalability: Template now used by 12 regional offices

**Strategic Value Points**:
- Enhanced regulatory efficiency
- Improved public transparency
- Scientific rigor maintained
- Enterprise-grade security
- Team collaboration enabled

## Key Takeaways for Audience

### For Technical Staff:
- Same tools for development and production
- Version control built into workflow
- Package management ensures consistency
- Statistical capabilities rival specialized tools

### for Management:
- Faster response to public concerns
- Reduced manual effort through automation
- Enhanced transparency builds public trust
- Scalable across government departments

### For IT/Security:
- Enterprise-grade platform with proper access controls
- On-premises deployment options available
- Validated package repositories for security
- Audit trails for regulatory compliance

## Demo Dos and Don'ts

### Do:
- Emphasize the dual audience (technical + public)
- Show actual code being executed
- Highlight the speed of analysis
- Demonstrate mobile responsiveness of dashboard
- Connect to real-world government challenges

### Don't:
- Get lost in technical details
- Ignore the public transparency aspect
- Rush through the deployment section
- Forget to mention regulatory compliance features

## Technical Backup

If live demo fails:
- Pre-rendered HTML report available
- Screenshots of key outputs prepared
- Recorded screen capture as fallback
- Static versions of interactive maps ready

## Questions to Anticipate

1. **"How secure is this for sensitive government data?"**
   - On-premises deployment options
   - Enterprise security features
   - Audit trails and access controls

2. **"What about staff training and adoption?"**
   - Familiar R environment reduces learning curve
   - Built-in collaboration features
   - Comprehensive support and training available

3. **"How does this integrate with existing IT infrastructure?"**
   - Flexible deployment options
   - SSO integration available
   - Compatible with existing database systems

4. **"What's the total cost of ownership?"**
   - Reduced manual effort and faster turnaround
   - Eliminated need for multiple specialized tools
   - Improved staff productivity and satisfaction