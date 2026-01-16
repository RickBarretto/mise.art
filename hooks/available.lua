-- Returns a list of available versions for the tool
-- Documentation: https://mise.jdx.dev/tool-plugin-development.html#available-hook

function PLUGIN:Available(ctx)
    local http = require("http")
    local json = require("json")

    local repo_url = "https://api.github.com/repos/arturo-lang/arturo/releases"

    -- Mise automatically handles GitHub authentication
    local resp, err = http.get({
        url = repo_url,
    })

    if err ~= nil then
        error("Failed to fetch versions: " .. err)
    end
    if resp.status_code ~= 200 then
        error("GitHub API returned status " .. resp.status_code .. ": " .. resp.body)
    end

    local tags = json.decode(resp.body)
    local result = {}

    -- Process Releases
    for _, tag_info in ipairs(tags) do
        local version = tag_info.name
        local version = tag_info.tag_name:gsub("^v", "")
        local is_prerelease = tag_info.prerelease or false
        local note = is_prerelease and "pre-release" or nil

        table.insert(result, {
            version = version,
            note = note,
        })
    end

    return result

end
