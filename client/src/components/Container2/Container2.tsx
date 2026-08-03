import { useState } from "react";
import { searchBlocks } from "../../api/client";
import InfoTooltip from "../common/InfoTooltip";
import Modal from "../common/Modal";
import type { BlockRecord } from "../../types";
import "./Container2.css";

interface Container2Props {
  onBlockSelected: (block: BlockRecord | null) => void;
  selectedBlock: BlockRecord | null;
}

export default function Container2({
  onBlockSelected,
  selectedBlock,
}: Container2Props) {
  const [blockNumber, setBlockNumber] = useState("");
  const [subBlockNumber, setSubBlockNumber] = useState("0");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [duplicates, setDuplicates] = useState<BlockRecord[] | null>(null);

  const handleApply = async () => {
    const blockNum = parseInt(blockNumber, 10);
    const subBlockNum = parseInt(subBlockNumber || "0", 10);

    if (isNaN(blockNum)) {
      setError("Please enter a valid block number.");
      return;
    }

    setLoading(true);
    setError(null);
    setDuplicates(null);

    try {
      const results = await searchBlocks(blockNum, subBlockNum);

      if (results.length === 0) {
        setError(
          "The block does not exist or is already retired. Please select a valid active block."
        );
        onBlockSelected(null);
      } else if (results.length === 1) {
        onBlockSelected(results[0]!);
      } else {
        setDuplicates(results);
      }
    } catch (err) {
      setError(
        err instanceof Error ? err.message : "Failed to search blocks."
      );
    } finally {
      setLoading(false);
    }
  };

  const handleSelectDuplicate = (block: BlockRecord) => {
    setDuplicates(null);
    onBlockSelected(block);
  };

  const handleClear = () => {
    setBlockNumber("");
    setSubBlockNumber("0");
    onBlockSelected(null);
    setError(null);
  };

  return (
    <section className="container2">
      <div className="filter-header">
        <h2>Block Filter</h2>
        <InfoTooltip text="Filter the dashboard to a specific block. Enter an active block and sub-block numbers to drill down into parcel-level analytics." />
      </div>

      <div className="filter-controls">
        <div className="filter-field">
          <label htmlFor="block-number">Block Number</label>
          <input
            id="block-number"
            type="number"
            value={blockNumber}
            onChange={(e) => setBlockNumber(e.target.value)}
            placeholder="e.g. 6100"
            min={0}
          />
        </div>

        <div className="filter-field">
          <label htmlFor="sub-block-number">Sub-Block Number</label>
          <input
            id="sub-block-number"
            type="number"
            value={subBlockNumber}
            onChange={(e) => setSubBlockNumber(e.target.value)}
            placeholder="0"
            min={0}
          />
        </div>

        <div className="filter-actions">
          <button
            className="btn-apply"
            onClick={handleApply}
            disabled={loading || !blockNumber}
          >
            {loading ? "Searching..." : "Apply"}
          </button>
          {selectedBlock && (
            <button className="btn-clear" onClick={handleClear}>
              Clear
            </button>
          )}
        </div>
      </div>


      {error && (
        <div className="filter-error">
          <span>⚠</span> {error}
        </div>
      )}

      {duplicates && (
        <Modal
          title="Multiple Blocks Found"
          onClose={() => setDuplicates(null)}
        >
          <p className="duplicate-info">
            Multiple active blocks match your query. Please select one:
          </p>
          <table className="duplicate-table">
            <thead>
              <tr>
                <th>ObjectID</th>
                <th>Name</th>
                <th>LandType</th>
                <th>IsTax</th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {duplicates.map((block) => (
                <tr key={block.ObjectID}>
                  <td>{block.ObjectID}</td>
                  <td>{block.Name}</td>
                  <td>{block.LandType || "—"}</td>
                  <td>{block.IsTax ? "Yes" : "No"}</td>
                  <td>
                    <button
                      className="btn-select"
                      onClick={() => handleSelectDuplicate(block)}
                    >
                      Select
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </Modal>
      )}
    </section>
  );
}
