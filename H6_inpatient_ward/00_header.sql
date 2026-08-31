--
-- PostgreSQL database dump
--

\restrict B361OJRD7RNrdHhBMsc0TP8oe954GOSZZUs1E1kMzoMe7sfnkupn0awCOmbm4vb

-- Dumped from database version 16.15 (Debian 16.15-1.pgdg13+2)
-- Dumped by pg_dump version 17.6

-- Started on 2026-08-24 22:58:44

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16660)
-- Name: hospital_h6; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA hospital_h6;


ALTER SCHEMA hospital_h6 OWNER TO postgres;

--
-- TOC entry 251 (class 1255 OID 16838)
-- Name: fn_admissions_audit(); Type: FUNCTION; Schema: hospital_h6; Owner: postgres
--

CREATE FUNCTION hospital_h6.fn_admissions_audit() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO hospital_h6.admissions_audit
            (admission_id, operation, new_data)
        VALUES
            (NEW.admission_id, 'INSERT', to_jsonb(NEW));

    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO hospital_h6.admissions_audit
            (admission_id, operation, old_data, new_data)
        VALUES
            (OLD.admission_id, 'UPDATE', to_jsonb(OLD), to_jsonb(NEW));

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO hospital_h6.admissions_audit
            (admission_id, operation, old_data)
        VALUES
            (OLD.admission_id, 'DELETE', to_jsonb(OLD));
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION hospital_h6.fn_admissions_audit() OWNER TO postgres;

--
-- TOC entry 263 (class 1255 OID 16657)
-- Name: record_break_glass_access(text, text, text, text, inet); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.record_break_glass_access(p_user_id text, p_patient_id text, p_access_reason text, p_access_purpose text, p_source_ip inet DEFAULT NULL::inet) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_audit_id BIGINT;
BEGIN
  IF NOT EXISTS (SELECT 1 FROM public.app_users WHERE user_id = p_user_id) THEN
    RAISE EXCEPTION 'Unknown application user: %', p_user_id;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM public.patients WHERE patient_id = p_patient_id) THEN
    RAISE EXCEPTION 'Unknown patient: %', p_patient_id;
  END IF;

  INSERT INTO public.break_glass_access_audit
    (user_id, patient_id, access_reason, access_purpose, source_ip)
  VALUES
    (p_user_id, p_patient_id, p_access_reason, p_access_purpose, p_source_ip)
  RETURNING audit_id INTO v_audit_id;

  RETURN v_audit_id;
END;
$$;


ALTER FUNCTION public.record_break_glass_access(p_user_id text, p_patient_id text, p_access_reason text, p_access_purpose text, p_source_ip inet) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 244 (class 1259 OID 16728)
-- Name: admissions; Type: TABLE; Schema: hospital_h6; Owner: postgres
--

