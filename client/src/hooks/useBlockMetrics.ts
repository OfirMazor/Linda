import { useEffect, useRef, useState } from "react";
import {
  getParcelsForBlock,
  getOwnershipForBlock,
  getProcessesForBlock,
  getPAIForBlock,
} from "../api/client";
import type {
  ParcelRecord,
  OwnershipRecord,
  CadastreProcess,
  PAIResult,
} from "../types";

export interface OwnershipData {
  parcels: ParcelRecord[];
  ownership: OwnershipRecord[];
}

export interface ProcessesData {
  processes: CadastreProcess[];
  blockGeometry: GeoJSON.Geometry | null;
}

export interface BlockMetrics {
  ownership: { data: OwnershipData | null; loading: boolean };
  "cadastral-diary": { data: ProcessesData | null; loading: boolean };
  pai: { data: PAIResult[] | null; loading: boolean };
}

export function useBlockMetrics(blockGlobalId: string | null): BlockMetrics {
  const [ownershipData, setOwnershipData] = useState<OwnershipData | null>(null);
  const [ownershipLoading, setOwnershipLoading] = useState(false);
  const [processesData, setProcessesData] = useState<ProcessesData | null>(null);
  const [processesLoading, setProcessesLoading] = useState(false);
  const [paiData, setPaiData] = useState<PAIResult[] | null>(null);
  const [paiLoading, setPaiLoading] = useState(false);

  const abortRef = useRef<AbortController | null>(null);

  useEffect(() => {
    if (!blockGlobalId) {
      setOwnershipData(null);
      setProcessesData(null);
      setPaiData(null);
      return;
    }

    abortRef.current?.abort();
    const controller = new AbortController();
    abortRef.current = controller;

    setOwnershipData(null);
    setProcessesData(null);
    setPaiData(null);
    setOwnershipLoading(true);
    setProcessesLoading(true);
    setPaiLoading(true);

    Promise.all([getParcelsForBlock(blockGlobalId), getOwnershipForBlock(blockGlobalId)])
      .then(([parcels, ownership]) => {
        if (!controller.signal.aborted) {
          setOwnershipData({ parcels, ownership });
          setOwnershipLoading(false);
        }
      })
      .catch(() => {
        if (!controller.signal.aborted) setOwnershipLoading(false);
      });

    getProcessesForBlock(blockGlobalId)
      .then((data) => {
        if (!controller.signal.aborted) {
          setProcessesData(data);
          setProcessesLoading(false);
        }
      })
      .catch(() => {
        if (!controller.signal.aborted) setProcessesLoading(false);
      });

    getPAIForBlock(blockGlobalId)
      .then((data) => {
        if (!controller.signal.aborted) {
          setPaiData(data);
          setPaiLoading(false);
        }
      })
      .catch(() => {
        if (!controller.signal.aborted) setPaiLoading(false);
      });

    return () => controller.abort();
  }, [blockGlobalId]);

  return {
    ownership: { data: ownershipData, loading: ownershipLoading },
    "cadastral-diary": { data: processesData, loading: processesLoading },
    pai: { data: paiData, loading: paiLoading },
  };
}
