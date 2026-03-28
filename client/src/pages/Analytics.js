import React, { useState } from 'react';

const styles = {
  page: {
    fontFamily: "'IBM Plex Mono', 'Courier New', monospace",
    background: '#0a0e1a',
    minHeight: '100vh',
    color: '#e2e8f0',
    padding: '2rem',
  },
  header: {
    borderBottom: '1px solid #1e3a5f',
    paddingBottom: '1rem',
    marginBottom: '2rem',
  },
  title: {
    fontSize: '1.1rem',
    fontWeight: '600',
    color: '#38bdf8',
    letterSpacing: '0.15em',
    textTransform: 'uppercase',
    margin: 0,
  },
  subtitle: {
    fontSize: '0.75rem',
    color: '#64748b',
    marginTop: '0.25rem',
    letterSpacing: '0.05em',
  },
  grid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(auto-fit, minmax(480px, 1fr))',
    gap: '1.5rem',
  },
  card: {
    background: '#0f172a',
    border: '1px solid #1e293b',
    borderRadius: '8px',
    padding: '1.5rem',
  },
  cardTitle: {
    fontSize: '0.7rem',
    fontWeight: '600',
    color: '#38bdf8',
    letterSpacing: '0.12em',
    textTransform: 'uppercase',
    marginBottom: '0.25rem',
  },
  cardDesc: {
    fontSize: '0.72rem',
    color: '#64748b',
    marginBottom: '1rem',
    lineHeight: '1.5',
  },
  inputRow: {
    display: 'flex',
    gap: '0.5rem',
    marginBottom: '1rem',
    alignItems: 'center',
  },
  input: {
    flex: 1,
    background: '#0a0e1a',
    border: '1px solid #1e3a5f',
    borderRadius: '4px',
    padding: '0.4rem 0.75rem',
    color: '#e2e8f0',
    fontSize: '0.78rem',
    fontFamily: 'inherit',
    outline: 'none',
  },
  button: {
    background: 'transparent',
    border: '1px solid #38bdf8',
    borderRadius: '4px',
    color: '#38bdf8',
    padding: '0.4rem 1rem',
    fontSize: '0.72rem',
    fontFamily: 'inherit',
    letterSpacing: '0.08em',
    cursor: 'pointer',
    textTransform: 'uppercase',
    transition: 'background 0.15s',
    whiteSpace: 'nowrap',
  },
  table: {
    width: '100%',
    borderCollapse: 'collapse',
    fontSize: '0.75rem',
  },
  th: {
    textAlign: 'left',
    padding: '0.4rem 0.6rem',
    color: '#64748b',
    fontSize: '0.65rem',
    letterSpacing: '0.1em',
    textTransform: 'uppercase',
    borderBottom: '1px solid #1e293b',
  },
  td: {
    padding: '0.45rem 0.6rem',
    borderBottom: '1px solid #0a0e1a',
    color: '#cbd5e1',
  },
  tdAccent: {
    padding: '0.45rem 0.6rem',
    borderBottom: '1px solid #0a0e1a',
    color: '#38bdf8',
    fontWeight: '600',
  },
  emptyRow: {
    textAlign: 'center',
    padding: '1.5rem',
    color: '#334155',
    fontSize: '0.72rem',
    letterSpacing: '0.05em',
  },
  badge: {
    display: 'inline-block',
    padding: '0.15rem 0.5rem',
    borderRadius: '3px',
    fontSize: '0.65rem',
    fontWeight: '600',
    letterSpacing: '0.05em',
  },
};

function ScoreBar({ value, max = 10 }) {
  const pct = (value / max) * 100;
  const color = value >= 9 ? '#ef4444' : value >= 7 ? '#f97316' : value >= 4 ? '#eab308' : '#22c55e';
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
      <div style={{ flex: 1, background: '#1e293b', borderRadius: '2px', height: '4px' }}>
        <div style={{ width: `${pct}%`, background: color, height: '4px', borderRadius: '2px' }} />
      </div>
      <span style={{ color, minWidth: '28px', textAlign: 'right', fontSize: '0.72rem' }}>{value}</span>
    </div>
  );
}

function DataTable({ headers, rows }) {
  if (!rows.length) return <div style={styles.emptyRow}>No data — run the query.</div>;
  return (
    <table style={styles.table}>
      <thead>
        <tr>{headers.map((h, i) => <th key={i} style={styles.th}>{h}</th>)}</tr>
      </thead>
      <tbody>
        {rows.map((row, i) => (
          <tr key={i} style={{ background: i % 2 === 0 ? 'transparent' : '#0a0e1a' }}>
            {row.map((cell, j) => <td key={j} style={j === 0 ? styles.tdAccent : styles.td}>{cell}</td>)}
          </tr>
        ))}
      </tbody>
    </table>
  );
}

export default function Analytics() {
  const [cvssData, setCvssData]         = useState([]);
  const [licenseData, setLicenseData]   = useState([]);
  const [severityData, setSeverityData] = useState([]);
  const [divisionData, setDivisionData] = useState([]);
  const [sourceReg, setSourceReg]       = useState('');
  const [loading, setLoading]           = useState({});

  const run = (key, fn) => async () => {
    setLoading(l => ({ ...l, [key]: true }));
    await fn();
    setLoading(l => ({ ...l, [key]: false }));
  };

  const fetchAvgCVSS = run('cvss', async () => {
    // const res = await fetch('/avg-cvss-by-package');
    // const json = await res.json();
    // setCvssData(json.data);
    setCvssData([["log4j", 10, 1], ["lodash", 9.8, 3], ["numpy", 8.5, 1], ["express", 6.2, 1], ["openssl", 5.5, 1]]);
  });

  const fetchLicenses = run('license', async () => {
    // const res = await fetch('/licenses-multiple-versions');
    // const json = await res.json();
    // setLicenseData(json.data);
    setLicenseData([["MIT License", "Permissive", 2], ["GPL v3", "Copyleft", 1]]);
  });

  const fetchSeverity = run('severity', async () => {
    // const res = await fetch('/packages-above-avg-severity');
    // const json = await res.json();
    // setSeverityData(json.data);
    setSeverityData([["log4j", 10], ["lodash", 9], ["numpy", 8]]);
  });

  const fetchDivision = run('division', async () => {
    // if (!sourceReg.trim()) return;
    // const res = await fetch(`/projects-depend-all-packages?sourceReg=${encodeURIComponent(sourceReg)}`);
    // const json = await res.json();
    // setDivisionData(json.data);
    setDivisionData([[1, "OpenTrack"]]);
  });

  const btnLabel = (key, label) => loading[key] ? '...' : label;

  return (
    <div style={styles.page}>
      <div style={styles.header}>
        <h1 style={styles.title}>⬡ Analytics</h1>
        <p style={styles.subtitle}>Aggregated security intelligence across all audited packages</p>
      </div>

      <div style={styles.grid}>

        {/* Query 7: GROUP BY */}
        <div style={styles.card}>
          <div style={styles.cardTitle}>Avg CVSS Score by Package</div>
          <div style={styles.cardDesc}>Groups all security findings by package and computes the average CVSS severity score.</div>
          <div style={styles.inputRow}>
            <button style={styles.button} onClick={fetchAvgCVSS}
              onMouseEnter={e => e.target.style.background = '#0c2a3e'}
              onMouseLeave={e => e.target.style.background = 'transparent'}>
              {btnLabel('cvss', '▶ Run')}
            </button>
          </div>
          <table style={styles.table}>
            <thead>
              <tr>
                <th style={styles.th}>Package</th>
                <th style={styles.th}>Avg CVSS</th>
                <th style={styles.th}>Findings</th>
              </tr>
            </thead>
            <tbody>
              {cvssData.length === 0
                ? <tr><td colSpan={3} style={styles.emptyRow}>No data — run the query.</td></tr>
                : cvssData.map((row, i) => (
                  <tr key={i}>
                    <td style={styles.tdAccent}>{row[0]}</td>
                    <td style={{ ...styles.td, width: '160px' }}><ScoreBar value={row[1]} /></td>
                    <td style={styles.td}>{row[2]}</td>
                  </tr>
                ))}
            </tbody>
          </table>
        </div>

        {/* Query 8: HAVING */}
        <div style={styles.card}>
          <div style={styles.cardTitle}>Licenses Used by Multiple Package Versions</div>
          <div style={styles.cardDesc}>Returns licenses applied to more than one package version: flags widespread license obligations.</div>
          <div style={styles.inputRow}>
            <button style={styles.button} onClick={fetchLicenses}
              onMouseEnter={e => e.target.style.background = '#0c2a3e'}
              onMouseLeave={e => e.target.style.background = 'transparent'}>
              {btnLabel('license', '▶ Run')}
            </button>
          </div>
          <table style={styles.table}>
            <thead>
              <tr>
                <th style={styles.th}>License</th>
                <th style={styles.th}>Type</th>
                <th style={styles.th}>Usage Count</th>
              </tr>
            </thead>
            <tbody>
              {licenseData.length === 0
                ? <tr><td colSpan={3} style={styles.emptyRow}>No data — run the query.</td></tr>
                : licenseData.map((row, i) => (
                  <tr key={i}>
                    <td style={styles.tdAccent}>{row[0]}</td>
                    <td style={styles.td}>
                      <span style={{
                        ...styles.badge,
                        background: row[1] === 'Copyleft' ? '#450a0a' : '#042f2e',
                        color: row[1] === 'Copyleft' ? '#fca5a5' : '#6ee7b7',
                      }}>{row[1]}</span>
                    </td>
                    <td style={styles.td}>{row[2]}</td>
                  </tr>
                ))}
            </tbody>
          </table>
        </div>

        {/* Query 9: Nested Aggregation */}
        <div style={styles.card}>
          <div style={styles.cardTitle}>Packages Above Average Severity</div>
          <div style={styles.cardDesc}>Finds packages whose average finding severity exceeds the overall average: highest-risk dependencies.</div>
          <div style={styles.inputRow}>
            <button style={styles.button} onClick={fetchSeverity}
              onMouseEnter={e => e.target.style.background = '#0c2a3e'}
              onMouseLeave={e => e.target.style.background = 'transparent'}>
              {btnLabel('severity', '▶ Run')}
            </button>
          </div>
          <table style={styles.table}>
            <thead>
              <tr>
                <th style={styles.th}>Package</th>
                <th style={styles.th}>Avg Severity</th>
              </tr>
            </thead>
            <tbody>
              {severityData.length === 0
                ? <tr><td colSpan={2} style={styles.emptyRow}>No data — run the query.</td></tr>
                : severityData.map((row, i) => (
                  <tr key={i}>
                    <td style={styles.tdAccent}>{row[0]}</td>
                    <td style={{ ...styles.td, width: '160px' }}><ScoreBar value={row[1]} /></td>
                  </tr>
                ))}
            </tbody>
          </table>
        </div>

        {/* Query 10: Division */}
        <div style={styles.card}>
          <div style={styles.cardTitle}>Projects Depending on All Packages from a Registry</div>
          <div style={styles.cardDesc}>Enter a package registry to find all projects that depend on every package from that source.</div>
          <div style={styles.inputRow}>
            <input
              style={styles.input}
              type="text"
              placeholder="e.g. npmjs.com"
              value={sourceReg}
              onChange={e => setSourceReg(e.target.value)}
              onKeyDown={e => e.key === 'Enter' && fetchDivision()}
            />
            <button style={styles.button} onClick={fetchDivision}
              onMouseEnter={e => e.target.style.background = '#0c2a3e'}
              onMouseLeave={e => e.target.style.background = 'transparent'}>
              {btnLabel('division', '▶ Run')}
            </button>
          </div>
          <DataTable headers={['Project ID', 'Project Name']} rows={divisionData} />
        </div>

      </div>
    </div>
  );
}