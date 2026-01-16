-- Configures environment variables for the installed tool
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#envkeys-hook

function PLUGIN:EnvKeys(ctx)
    -- Available context:
    -- ctx.path - Main installation path
    -- ctx.runtimeVersion - Full version string
    -- ctx.sdkInfo[PLUGIN.name] - SDK information

    local mainPath = ctx.path

    local sep = package.config:sub(1, 1)
    local function join(...)
        return table.concat({ ... }, sep)
    end

    local function home_dir()
        local home = os.getenv("HOME") or os.getenv("USERPROFILE")
        if not home or home == "" then
            error("Unable to determine home directory for ~/.arturo")
        end
        return home
    end

    local arturo_home = join(home_dir(), ".arturo")

    return {
        {
            key = "PATH",
            value = join(arturo_home, "bin"),
        },
        {
            key = "PATH",
            value = join(arturo_home, "packages", "bin"),
        },
    }

end
