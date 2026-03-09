/**
 * Chart hook - renders SVG-based charts from data attributes.
 * Supports bar, line, area, and pie chart types.
 */
const Chart = {
  mounted() {
    this.renderChart();
  },

  updated() {
    this.renderChart();
  },

  renderChart() {
    const el = this.el;
    const type = el.dataset.chartType || "bar";
    let data;

    try {
      data = JSON.parse(el.dataset.chartData || "[]");
    } catch {
      return;
    }

    if (!data.length) return;

    const colors = this.getThemeColors();
    const width = el.offsetWidth;
    const height = el.offsetHeight || 350;
    const padding = { top: 20, right: 20, bottom: 40, left: 50 };
    const chartWidth = width - padding.left - padding.right;
    const chartHeight = height - padding.top - padding.bottom;

    let svg = "";

    if (type === "pie") {
      svg = this.renderPie(data, width, height, colors);
    } else {
      const maxVal = Math.max(...data.map((d) => d.value));
      const minVal = 0;

      svg = `<svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg">`;

      // Y-axis grid lines
      for (let i = 0; i <= 4; i++) {
        const y = padding.top + chartHeight - (chartHeight / 4) * i;
        const val = Math.round(minVal + ((maxVal - minVal) / 4) * i);
        svg += `<line x1="${padding.left}" y1="${y}" x2="${width - padding.right}" y2="${y}" stroke="${colors.border}" stroke-dasharray="4"/>`;
        svg += `<text x="${padding.left - 8}" y="${y + 4}" text-anchor="end" fill="${colors.muted}" font-size="12">${val}</text>`;
      }

      if (type === "bar") {
        svg += this.renderBars(data, padding, chartWidth, chartHeight, maxVal, colors);
      } else if (type === "line" || type === "area") {
        svg += this.renderLineArea(
          data,
          padding,
          chartWidth,
          chartHeight,
          maxVal,
          type,
          colors
        );
      }

      // X-axis labels
      const barWidth = chartWidth / data.length;
      data.forEach((d, i) => {
        const x = padding.left + barWidth * i + barWidth / 2;
        svg += `<text x="${x}" y="${height - 8}" text-anchor="middle" fill="${colors.muted}" font-size="12">${d.label}</text>`;
      });

      svg += `</svg>`;
    }

    el.innerHTML = svg;
  },

  renderBars(data, padding, chartWidth, chartHeight, maxVal, colors) {
    let svg = "";
    const barWidth = chartWidth / data.length;
    const barPadding = barWidth * 0.2;
    const chartColors = [
      colors.chart1,
      colors.chart2,
      colors.chart3,
      colors.chart4,
      colors.chart5,
    ];

    data.forEach((d, i) => {
      const barH = (d.value / maxVal) * chartHeight;
      const x = padding.left + barWidth * i + barPadding;
      const y = padding.top + chartHeight - barH;
      const w = barWidth - barPadding * 2;
      const color = chartColors[i % chartColors.length];
      svg += `<rect x="${x}" y="${y}" width="${w}" height="${barH}" rx="4" fill="${color}" opacity="0.9"/>`;
    });

    return svg;
  },

  renderLineArea(data, padding, chartWidth, chartHeight, maxVal, type, colors) {
    let svg = "";
    const barWidth = chartWidth / data.length;
    const points = data.map((d, i) => ({
      x: padding.left + barWidth * i + barWidth / 2,
      y: padding.top + chartHeight - (d.value / maxVal) * chartHeight,
    }));

    const pathD = points.map((p, i) => `${i === 0 ? "M" : "L"}${p.x},${p.y}`).join(" ");

    if (type === "area") {
      const areaPath = `${pathD} L${points[points.length - 1].x},${padding.top + chartHeight} L${points[0].x},${padding.top + chartHeight} Z`;
      svg += `<path d="${areaPath}" fill="${colors.chart1}" opacity="0.2"/>`;
    }

    svg += `<path d="${pathD}" fill="none" stroke="${colors.chart1}" stroke-width="2"/>`;

    points.forEach((p) => {
      svg += `<circle cx="${p.x}" cy="${p.y}" r="4" fill="${colors.chart1}"/>`;
    });

    return svg;
  },

  renderPie(data, width, height, colors) {
    const cx = width / 2;
    const cy = height / 2;
    const radius = Math.min(cx, cy) - 20;
    const total = data.reduce((sum, d) => sum + d.value, 0);
    const chartColors = [
      colors.chart1,
      colors.chart2,
      colors.chart3,
      colors.chart4,
      colors.chart5,
    ];

    let svg = `<svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg">`;
    let startAngle = -Math.PI / 2;

    data.forEach((d, i) => {
      const sliceAngle = (d.value / total) * 2 * Math.PI;
      const endAngle = startAngle + sliceAngle;
      const x1 = cx + radius * Math.cos(startAngle);
      const y1 = cy + radius * Math.sin(startAngle);
      const x2 = cx + radius * Math.cos(endAngle);
      const y2 = cy + radius * Math.sin(endAngle);
      const largeArc = sliceAngle > Math.PI ? 1 : 0;
      const color = chartColors[i % chartColors.length];

      svg += `<path d="M${cx},${cy} L${x1},${y1} A${radius},${radius} 0 ${largeArc},1 ${x2},${y2} Z" fill="${color}" opacity="0.9"/>`;
      startAngle = endAngle;
    });

    svg += `</svg>`;
    return svg;
  },

  getThemeColors() {
    const style = getComputedStyle(document.documentElement);
    return {
      chart1: style.getPropertyValue("--color-chart-1").trim() || "#e76e50",
      chart2: style.getPropertyValue("--color-chart-2").trim() || "#2a9d90",
      chart3: style.getPropertyValue("--color-chart-3").trim() || "#264653",
      chart4: style.getPropertyValue("--color-chart-4").trim() || "#e9c46a",
      chart5: style.getPropertyValue("--color-chart-5").trim() || "#f4a261",
      border: style.getPropertyValue("--color-border").trim() || "#e5e7eb",
      muted:
        style.getPropertyValue("--color-muted-foreground").trim() || "#6b7280",
    };
  },
};

export default Chart;
