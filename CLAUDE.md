# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

OsmoSMSC is a scalable Smalltalk-based Short Message Service Center (SMSC) that uses MongoDB for storage. It receives SMS via SMPP, stores them, and delivers via SMPP or SS7/MAP protocols.

## Build & Test Commands

**Run Smalltalk CI tests:**
```bash
$SMALLTALK_CI_HOME/run.sh
```

**Run integration tests (requires running MongoDB and Pharo image):**
```bash
# All integration tests
bash integration-tests/integration-tests.sh

# Individual test files (from repo root)
python2 -m pytest integration-tests/om_rest_test.py \
    --pharo-vm=<path-to-pharo> \
    --pharo-image=OsmoSmsc.image \
    --image-launch=<path-to-bootstrap.st>

python2 -m pytest integration-tests/inserter_test.py ...
python2 -m pytest integration-tests/delivery_test.py ...
```

**Build documentation:**
```bash
make -C docs
```

**Docker build:**
```bash
docker build -t pharo_prepare -f docker/Dockerfile.prepare .
docker build -t osmo-smsc -f docker/Dockerfile.osmo-smsc .
```

## Architecture

### Core Components

The system consists of three main process types that can run independently and scale horizontally:

1. **Inserter** (`ShortMessageCenter-Inserter.package`) - Receives SMPP SubmitSM/DeliverSM messages and stores them in MongoDB. Multiple inserters can run in parallel.

2. **Delivery** (`ShortMessageCenter-Delivery.package`) - Picks up pending messages and delivers via SMPP or SS7/MAP. Uses a wake-up mechanism via MongoDB tailable cursors on capped collections. Multiple delivery workers compete for messages using CAS locking.

3. **OM (Operations & Maintenance)** (`ShortMessageCenter-REST.package`) - REST API for configuration and monitoring.

### Database Layer (`ShortMessageCenter-Database.package`)

- Uses MongoDB with two main collections: `sms` (message storage) and `locks` (destination locking)
- Implements a CAS-based locking protocol to prevent multiple workers from delivering to the same destination
- Uses capped collections with tailable cursors for notification/wake-up mechanism

### Key Dependencies (from Baseline)

- **VoyageMongo/MongoTalk** - MongoDB integration
- **SMPP** - SMPP protocol implementation
- **TCAP/ASN1** - SS7/MAP protocol stack
- **ZincHTTPComponents** - REST API framework
- **OsmoLogging** - Logging framework
- **StatsDClient** - Metrics

### Smalltalk Code Structure

Code is stored in FileTree format under `mc/` directory:
- `*.package/` - Monticello packages
- `*.class/` - Class definitions with methods in `instance/` and `class/` subdirectories
- Method files are `.st` with method name as filename

## Configuration

The system uses MongoDB databases:
- `om-test` / `smsc-test` - Test databases (dropped before each test)
- Configuration for links (SMPP/SS7) is done via REST API on port 1700
